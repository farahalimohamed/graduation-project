from rest_framework import serializers
from django.contrib.auth.models import User
from .models import Ambulance, Hospital, Profile, RequestHospital, firstaid

class UserSerializer(serializers.ModelSerializer):
    class Meta:
        model = User
        fields = '__all__'

class ProfileSerializer(serializers.ModelSerializer):
    class Meta:
        model = Profile
        fields = '__all__'

class FirstAidSerializer(serializers.ModelSerializer):
    class Meta:
        model = firstaid
        fields = '__all__'

class AmbulanceSerializer(serializers.ModelSerializer):
    class Meta:
        model = Ambulance
        fields = '__all__'

class HospitalRequestSerializer(serializers.ModelSerializer):
    class Meta:
        model = RequestHospital
        fields = '__all__'