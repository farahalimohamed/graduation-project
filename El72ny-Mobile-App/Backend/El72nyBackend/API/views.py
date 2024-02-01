# from rest_framework.permissions import IsAuthenticated
# from rest_framework.decorators import authentication_classes, permission_classes
# from rest_framework.authentication import TokenAuthentication
from math import atan2, cos, radians, sin, sqrt
from django.shortcuts import get_object_or_404, render
from django.contrib.auth.models import User
from .models import Ambulance, ChatMessage, Hospital, Profile, RequestHospital, Tracking, firstaid
from django.http import HttpResponse, JsonResponse
from django.contrib.auth import login, authenticate, logout
from rest_framework.response import Response
from .serializers import AmbulanceSerializer, FirstAidSerializer, HospitalRequestSerializer, ProfileSerializer
from rest_framework.decorators import api_view
from django.core import serializers
from django.db.models import Q
from rest_framework.generics import ListAPIView
# from rest_framework import filters
from django.db import IntegrityError
# from rest_framework.authtoken.models import Token


@api_view(['POST'])
def SignUp(request):
    data = request.data
    if User.objects.filter(username=data["username"]).exists() | User.objects.filter( email=data["email"]).exists() :
        return Response("Username or email already exists", status=503)
    else:
        user = User.objects.create_user(
            email=data["email"], password=data["password"], username=data["username"])
        user.save()
        is_doctor = data["is_doctor"]
        if is_doctor == "1":
            doctorId = request.FILES['doctorId']
        else:
            doctorId = ''

        try:
            profile = Profile(
                user=user, name=data["name"],
                phone_number=data["phone_number"], 
                birthdate=data["birthdate"],
                # pic=request.FILES["pic"],
                is_doctor=is_doctor,
                specialization=data["specialization"],
                doctorId=doctorId,
                availability=data["availability"], 
                gender=data["gender"],
                blood_type=data["blood_type"], 
                allergies=data["allergies"],
                weight=data["weight"], 
                medical_condition=data["medical_condition"],
                online = 0
            )
            profile.save()
            return Response("done")
        except IntegrityError as e:
            User.objects.get(username=data["username"]).delete()
            return Response("error creating a profile", status=404)


@api_view(['POST'])
def LogIn(request):
    data = request.data
    user = authenticate(
        request, username=data["username"], password=data["password"])
    if user is not None:
        p = Profile.objects.get(user_id=user.id)
        if p.is_doctor and not p.accepted:
            return Response("Profile is not accepted", status=320)
        login(request, user)
        p.online = 1
        p.save
        user_id = user.id
        # token, created = Token.objects.get_or_create(user=user)
        # return Response({'token': token.key, 'user_id': user_id, "profile":p.id})
        return Response({'user_id': user_id, "profile": p.id})
    else:
        return Response("Invalid username or password", status=404)


@api_view(['POST'])
def logout_view(request):
    Profile.objects.get(user_id = request.data['uid']).online = False
    return Response("logged out successfully.")


@api_view(['POST'])
def updateProfile(request):
    # user = request.user
    data = request.data
    try:
        uid = data["uid"]
        profile = Profile.objects.get(user=uid)
        profile.name=data['name']
        profile.medical_condition=data['medCon']
        profile.weight=data['weight']
        profile.blood_type=data['bt']
        profile.save()
        return Response("profile updated successfully.")
    except IntegrityError as e:
        return Response("fail", status=404)


@api_view(['POST'])
def ChangePassword(request):
    data = request.data
    uname = data['uname']
    password = data['pass']
    if User.objects.filter(username=uname).exists():
        user = User.objects.get(username=uname)
        user.set_password(password)
        user.save()
        return Response("changed successfully")
    else:
        return Response("user does not exist", status=404)


@api_view(['GET'])
def get_user(request, pk):
    # user = request.user
    try:
        profile = Profile.objects.get(user=pk)
        serializer = ProfileSerializer(profile, many=False)
        return Response(serializer.data)
    except IntegrityError as e:
        return Response("fail")


@api_view(['GET'])
def get_allDoctors(request):
    doctor = Profile.objects.filter(is_doctor=1, accepted =1)
    serializer = ProfileSerializer(doctor, many=True)
    return Response(serializer.data)

############################ CHAT PART###########


from django.core.files.storage import default_storage
@api_view(['POST'])
def sendMessages(request, pk):
    data = request.data
    user_id = data.get('user_id')
    profile = Profile.objects.get(user_id=user_id)
    doctor = Profile.objects.get(user=pk)

    # Get the uploaded file, if any
    pic = request.FILES.get('pic')

    # Create a new chat message with the body and optional pic
    new_chat = data["msg"]
    new_chat_message = ChatMessage.objects.create(
        body=new_chat, msg_sender=profile, msg_receiver=doctor, seen=False, pic=pic)

    # Save the pic to disk
    if pic:
        filename = f'{new_chat_message.pk}{pic.name}'
        default_storage.save(f'img/{filename}', pic)

    return JsonResponse({"body": new_chat_message.body}, safe=False)


@api_view(['GET'])
def receivedMessages(request, uid, pk):
    profile = Profile.objects.get(user_id=uid)
    doctor = Profile.objects.get(user=pk)
    arr = []
    unreads = 0
    chats = ChatMessage.objects.filter(msg_sender=doctor, msg_receiver=profile)
    for chat in chats:
        message = {'body': chat.body, 'pic': None}
        if chat.pic:
            message['pic'] = chat.pic.url
        arr.append(message)
        if not chat.seen:
            unreads += 1
    return JsonResponse({'messages': arr, 'unread_count': unreads})


# @api_view(['POST'])
# def sendMessages(request, pk):
#     data = request.data
#     user_id = data.get('user_id')
#     profile = Profile.objects.get(user_id=user_id)
#     doctor = Profile.objects.get(user=pk)
#     new_chat = data["msg"]
#     new_chat_message = ChatMessage.objects.create(
#         body=new_chat, msg_sender=profile, msg_receiver=doctor, seen=False)
#     print(new_chat)
#     return JsonResponse({"body": new_chat_message.body, }, safe=False)


# @api_view(['GET'])
# def receivedMessages(request, uid, pk):
#     profile = Profile.objects.get(user_id=uid)
#     doctor = Profile.objects.get(user=pk)
#     arr = []
#     unreads = 0
#     chats = ChatMessage.objects.filter(msg_sender=doctor, msg_receiver=profile)
#     for chat in chats:
#         arr.append(chat.body)
#         if not chat.seen:
#             unreads += 1
#     return JsonResponse({'messages': arr, 'unread_count': unreads})


def chat_history(request, uid, pk):
    # Get the doctor and user profiles
    doctor = Profile.objects.get(user_id=pk)
    user = Profile.objects.get(user_id=uid)

    # Retrieve all chat messages between the user and doctor
    chat_history = ChatMessage.objects.filter(
        (Q(msg_sender=user) & Q(msg_receiver=doctor)) |
        (Q(msg_sender=doctor) & Q(msg_receiver=user))
    )

    chat_history_serialized = serializers.serialize('json', chat_history)

    return HttpResponse(chat_history_serialized)


@api_view(['POST'])
def markMessagesAsSeen(request, uid, pk):
    doctor = Profile.objects.get(user_id=pk)
    user = Profile.objects.get(user_id=uid)

    chat_history = ChatMessage.objects.filter(
        msg_receiver=user,
        msg_sender=doctor,
        seen=False
    )

    chat_history.update(seen=True)

    return Response({'message': 'All received messages marked as seen.'})


class Doctor(ListAPIView):
    serializer_class = ProfileSerializer

    def get_queryset(self):
        user_id = self.kwargs['user_id']
        profile = Profile.objects.get(user_id=user_id)

        received_messages = ChatMessage.objects.filter(
            Q(msg_sender=profile) | Q(msg_receiver=profile))
        doctors_with_messages = Profile.objects.filter(Q(id__in=received_messages.values(
            'msg_sender')) | Q(id__in=received_messages.values('msg_receiver'))).exclude(id=profile.id)

        return doctors_with_messages


################## search for doctors and first aid###############
def search(request):
    query = request.GET.get('q', '')
    doctors = Profile.objects.filter(
        Q(is_doctor=True, accepted=True),
        Q(name__icontains=query) | Q(specialization__icontains=query)
    ).values('name', 'specialization', 'pic', 'id', 'availability')
    # Create a list of dictionaries containing the doctor's name, specialization, and profile picture URL
    results = []
    for doctor in doctors:
        result = {
            'name': doctor['name'],
            'specialization': doctor['specialization'],
            'pic': doctor['pic'],
            'id': doctor['id'],
            'availability': doctor['availability'],
        }
        results.append(result)
    # Search for first aid information
    first_aid = firstaid.objects.filter(
        name__icontains=query).values('name').distinct()
    # Add first aid information to results
    for item in first_aid:
        results.append(item)
    return JsonResponse(results, safe=False)


################## tracking part##################
############ User Request for an Ambulance###########
@api_view(["POST"])
def requestAmbulance(request):
    data = request.data
    uid = data["uid"]
    lat = radians(float(data["lat"]))
    lng = radians(float(data["lng"]))
    hospitals = Hospital.objects.all()

    R = 6373.0
    nearby_hospitals = []
    for hospital in hospitals:
        lat2 = radians(float(hospital.lat))
        lon2 = radians(float(hospital.lng))
        dlon = lon2 - lng
        dlat = lat2 - lat
        a = sin(dlat / 2)**2 + cos(lat) * cos(lat2) * sin(dlon / 2)**2
        c = 2 * atan2(sqrt(a), sqrt(1 - a))
        distance = R * c
        if distance < 10:  # 10 is the distance in km
            hospital.distance = distance
            nearby_hospitals.append(hospital)

    nearby_hospitals = sorted(
        nearby_hospitals, key=lambda hospital: hospital.distance)
    
    # if the hospital has rejected the request
    if RequestHospital.objects.filter(userId=uid).exists():
        existing_request = RequestHospital.objects.filter(userId=uid)
        for req in existing_request:
            hospital_to_remove = req.hospital
            req.seen = True
            req.save()
            if hospital_to_remove in nearby_hospitals:
                nearby_hospitals.remove(hospital_to_remove)

    # to check if the hospital has avaliable ambulances
    for hospital in nearby_hospitals:
        Amb = Ambulance.objects.filter(hospital_id=hospital.id, available=1)
        if Amb.exists():
            ReqHos = RequestHospital.objects.create(userlat=float(data["lat"]), userlng=float(
                data["lng"]), userId=uid, hospital=hospital, seen=0, userCase=data['ucase'])
            ReqHos.save()
            serializer = HospitalRequestSerializer(
                RequestHospital.objects.all(), many=True)
            return Response("request placed successfully.")


@api_view(['POST'])
def checkConnection(request):
    data = request.data
    uid = data['uid']
    if Tracking.objects.filter(userId=uid).exists():
        return Response({"ambid": Tracking.objects.get(userId=uid).ambulance.id}, status=200)
    else:
        return Response("no connection yet", status=404)


@api_view(['POST'])
def update_user_location(request):
    data = request.data
    user = data['user_id']
    tracking = get_object_or_404(Tracking, userId=user)
    userLat = data['Lat']
    userLng = data['Lng']
    tracking.userLat = userLat
    tracking.userLng = userLng
    tracking.save()
    return JsonResponse({'status': 'user loc updated success'})


@api_view(["POST"])
def deleteConnection(request):
    data = request.data
    uid = data["uid"]
    tracking = Tracking.objects.get(userId=uid)
    ambulance = tracking.ambulance
    ambulance.available = 1
    ambulance.save()
    try:
        tracking.delete()
        return Response("deleted successfully")
    except IntegrityError as e:
        return Response("fail")

############ ambulance part#####################


@api_view(["POST"])
def AmbLogin(request):
    data = request.data
    id = data["id"]
    password = data["password"]
    try:
        amb = Ambulance.objects.get(id=id)
        if amb.password == password:
            return JsonResponse({"ambId": amb.id}, safe=False)
        else:
            return Response('incorrect password', status=404)
    except IntegrityError as e:
        return Response("unregistered ambulance", status=503)


@api_view(["GET"])
def getConnection(request, ambid):
    ambulance = Ambulance.objects.get(id=ambid)
    if Tracking.objects.filter(ambulance=ambid).exists():
        tracking = Tracking.objects.get(ambulance=ambid)
        ambulanceLoc = {
            'lat': ambulance.Lat,
            'lng': ambulance.Lng,
        }
        userLoc = {
            'lat': tracking.userLat,
            'lng': tracking.userLng
        }
        return JsonResponse({"exists": 1, "ambloc": ambulanceLoc, "userloc": userLoc}, safe=False)
    else:
        return JsonResponse({"exists": 0}, safe=False)


@api_view(["POST"])
def update_ambulance_location(request):
    data = request.data
    latitude = data['Lat']
    longitude = data['Lng']
    ambId = data['id']
    ambulance = get_object_or_404(Ambulance, id=ambId)
    try:
        ambulance.Lat = latitude
        ambulance.Lng = longitude
        ambulance.save()
        return JsonResponse({'status': 'ambulance loc updated success'})
    except IntegrityError as e:
        return Response("fail")


############ HOSPITAL PART###################
@api_view(['POST'])
def HosLogin(request):
    data = request.data
    id = data["id"]
    password = data['password']
    try:
        hos = Hospital.objects.get(id=id)
        if hos.password == password:
            hos = RequestHospital.objects.filter(hospital_id=id, seen=False)
            serializer = HospitalRequestSerializer(hos, many=True)
            Amb = Ambulance.objects.filter(hospital_id=id, available=1)
            Ambserializer = AmbulanceSerializer(Amb, many=True)
            return render(request, 'home.html', {"requests": serializer.data, "Ambulances": Ambserializer.data})
        else:
            return HttpResponse('wrong password', status=404)
    except IntegrityError as e:
        return HttpResponse("unregistered hospital or wrong username", status=503)


@api_view(["POST"])
def HandleRequest(request):
    data = request.data
    request_id = data["request_id"]
    req = RequestHospital.objects.get(id=request_id)
    assign_Amb = data["ambulance_id"]
    amb = Ambulance.objects.get(id=assign_Amb)
    tracking = Tracking.objects.create(
        ambulance=amb, userId=req.userId, userLat=req.userlat, userLng=req.userlng)
    tracking.save()
    amb.available = False
    amb.save()
    RequestHospital.objects.filter(userId=req.userId).delete()
    return Response("connection done")


############### FIRST AID####################
@api_view(['GET'])
def get_firstAid(request):
    fa = firstaid.objects.all()
    serializer = FirstAidSerializer(fa, many=True)
    return Response(serializer.data)


@api_view(['GET'])
def get_oneFirstAid(request, pk):
    fa = firstaid.objects.get(id=pk)
    serializer = FirstAidSerializer(fa, many=False)
    return Response(serializer.data)


# NOT USED YET
@api_view(['PUT'])
def updateFirstAid(request, pk):
    data = request.data
    FA = firstaid.objects.get(id=pk)
    serializer = FirstAidSerializer(FA, data=data)
    if serializer.is_valid():
        serializer.save()
    return Response(serializer.data)

# import requests
# def convert_coordinates(request):
#     latitude = request.data['latitude']
#     longitude = request.data['longitude']
#     api_key = 'AIzaSyDkWapKK5xx_BkMSLYDQjrV6IIaM4W-rSE'
#     url = f'https://maps.googleapis.com/maps/api/geocode/json?latlng={latitude},{longitude}&key={api_key}'
#     response = requests.get(url)
#     data = response.json()
#     if data['status'] == 'OK':
#         address = data['results'][0]['formatted_address']
#     else:
#         address = 'Address not found'
#     return JsonResponse({'address': address})


@api_view(['GET'])
# @authentication_classes([TokenAuthentication])
# @permission_classes([IsAuthenticated])
def getdata(request):
    user = request.user
    try:
        p = Profile.objects.get(user=user)
        serializer = ProfileSerializer(p, many=False)
        return Response(serializer.data)
    except IntegrityError as e:
        return HttpResponse("couldn't find or wrong username", status=503)
