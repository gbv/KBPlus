package com.k_int.kbplus.auth

import java.util.Date

class Webhook {
  User user
  String name
  String url
  String format = 'JSON'
  String service
  int attempts = 0
  Date dateCreated
  Date lastModified = new Date()

  static constraints = {
    user()
    name()
    url()
    format()
    service()
    attempts()
  }
}
