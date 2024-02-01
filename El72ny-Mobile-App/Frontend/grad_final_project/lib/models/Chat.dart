import 'dart:convert';

class Chat {
  final String name, lastMessage, image, time, specialization;
  final bool isActive;
  final int id;

  Chat({
    this.name = '',
    this.lastMessage = '',
    this.image = '',
    this.time = '',
    this.isActive = false,
    this.id=0,
    this.specialization=''
  });
}