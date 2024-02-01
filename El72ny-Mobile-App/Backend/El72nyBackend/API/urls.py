from django.urls import path, include
from . import views

urlpatterns = [
    path('signup/', views.SignUp, name="Registraton"),
    path('login/', views.LogIn, name="LogIn"),
    path('logout/', views.logout_view, name="LogOut"),
    path('ChangePassword/', views.ChangePassword),
    path('profile/<str:pk>', views.get_user, name="Get Profile"),
    path('updateprofile/', views.updateProfile, name="Update Profile"),

    # chat urls
    path('sendd/<str:pk>', views.sendMessages),
    path('rec_msg/<str:uid>/<str:pk>', views.receivedMessages, name = "rec_msg"),
    path('Doctor/<str:user_id>', views.Doctor.as_view(), name = "Doctor"),
    path('detail/<str:uid>/<str:pk>', views.chat_history, name="detail"),
    path('seen/<str:uid>/<str:pk>', views.markMessagesAsSeen),

    # searchURL
    path('search',views.search),

    # get doctors for specialization
    path('doctors/', views.get_allDoctors),

    # track and update the location
    # user side
    path('ambulance/',views.requestAmbulance),
    path('updateUserLoc/', views.update_user_location),
    path('checkConnection/', views.checkConnection),
    path('getConnection/<str:ambid>', views.getConnection),
    # hospital side
    path('hospitalLogin/', views.HosLogin), 
    path('HandleRequest/',views.HandleRequest),
    # ambulance
    path('ambLogin/', views.AmbLogin, name="ambulance login"),
    path('updateAmbulanceLoc/', views.update_ambulance_location),
    
    path('deleteConnection/',views.deleteConnection),

    #First Aid
    path('firstaid/',views.get_firstAid),
    path('firstaid/<str:pk>',views.get_oneFirstAid),
    path('firstaidd/<str:pk>',views.updateFirstAid),


    path('getdata/', views.getdata),
]
