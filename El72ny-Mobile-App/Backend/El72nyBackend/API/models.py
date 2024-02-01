from django.db import models
from django.contrib.auth.models import User

# Create your models here.
class firstaid(models.Model):
   name = models.CharField(max_length=100)
   stepNum=models.CharField(max_length=20,null=True)
   video=models.FileField(upload_to='video',null=True)
   Description=models.CharField(max_length=5000,null=True)


class Profile(models.Model):
    # normal data
    user = models.OneToOneField(User, on_delete=models.CASCADE)
    name = models.CharField(max_length=100)
    phone_number = models.CharField(max_length=11)
    birthdate = models.DateField(null=True)
    gender = models.CharField(max_length=6, null=True, blank=True)
    blood_type = models.CharField(max_length=3, null=True, blank=True)
    allergies = models.CharField(max_length=100, null=True, blank=True)
    weight = models.CharField(max_length=10, null=True, blank=True)
    medical_condition = models.CharField(max_length=100, null=True, blank=True)
    pic = models.ImageField(upload_to="img", blank=True, null=True)

    # doctor imfo
    is_doctor = models.BooleanField()
    doctorId = models.ImageField(upload_to="img", null= True)
    specialization = models.CharField(max_length=100)
    online = models.BooleanField(default=False)
    availability = models.CharField(max_length=100, null=True, blank=True)
    rate = models.FloatField(null=True, blank=True, default=0)
    accepted = models.BooleanField(default=False, null=True)
    def __str__(self):
        return self.name


class Hospital(models.Model):
    name=models.CharField(max_length=100)
    lat =models.CharField(max_length=20)
    lng =models.CharField(max_length=20)
    password = models.CharField(max_length=16)
    

class Ambulance(models.Model):
    hospital =models.ForeignKey(Hospital, on_delete=models.CASCADE)
    Lat =models.CharField(max_length=20)
    Lng =models.CharField(max_length=20)
    available =models.BooleanField(default=True)
    password =models.CharField(max_length=20)


class Tracking(models.Model):
    ambulance = models.OneToOneField(Ambulance, on_delete=models.CASCADE)
    # tracking data
    userId = models.CharField(max_length=20, unique=True)
    userLat = models.CharField(max_length=20)
    userLng = models.CharField(max_length=20) 


class RequestHospital(models.Model):
    hospital=models.ForeignKey(Hospital, on_delete=models.CASCADE,unique=False)
    userId=models.CharField(max_length=30)
    userlat = models.FloatField()
    userlng = models.FloatField()
    seen = models.BooleanField(default=False)
    userCase = models.CharField(max_length=300)


class ChatMessage(models.Model):
    body = models.TextField(null=True)
    msg_sender = models.ForeignKey(
        Profile, on_delete=models.CASCADE, related_name="msg_sender")
    msg_receiver = models.ForeignKey(
        Profile, on_delete=models.CASCADE, related_name="msg_receiver")
    seen = models.BooleanField(default=False)
    pic = models.ImageField(upload_to="img", blank=True, null=True)


    def __str__(self):
        return self.body


# {
# "email":"email@example.com",
# "password":"email",
# "username":"email",
# "name":"email",
# "phone_number":"01118761066",
# "birthdate":"2001-09-30"
# }

# {
# "email":"doctor@example.com",
# "password":"doctor",
# "username":"doctor",
# "name":"doctor",
# "phone_number":"01118761066",
# "birthdate":"2001-09-30",
# "is_doctor":0
# }


# {
# "username":"past",
# "email":"past@example.com",
# "password":"past",
# "name":"past",
# "phone_number":"01118761066",
# "birthdate":"2001-09-30",
# "is_doctor":1,
# "gender":"female",
# "blood_type":"a+",
# "specialization":"Dentist",
# "availability":"12 pm - 6 am",
# "allergies":"",
# "medical_condition":""
# "doctorId": ""
# }

#################MAKE AMBULANCE REQUEST########################
# {
# "uid":0,
# "lat":31.20426330660097,
# "lng": 29.90581006933335
# }