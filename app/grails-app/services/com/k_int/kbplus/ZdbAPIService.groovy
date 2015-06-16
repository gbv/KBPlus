package com.k_int.kbplus

import groovyx.net.http.RESTClient
import groovyx.net.http.ContentType
import static groovyx.net.http.Method.GET

class ZdbAPIService {
  def target_service

  @javax.annotation.PostConstruct
  def init() {
    target_service = new RESTClient("https://services.dnb.de/sru/zdb")
  }

  def lookup(issn) {
    // https://services.dnb.de/sru/zdb?version=1.1&operation=searchRetrieve&query=iss%3D1862-4804&recordSchema=MARC21-xml

    def result = null

    try {
      target_service.request(GET, ContentType.XML) { request ->
        uri.query = [
          version:'1.1',
          operation:'searchRetrieve',
          query:"iss=${issn}",
          recordSchema:'MARC21-xml',
        ]

        response.success = { resp, data ->
          // data is the xml document
          result = data;
        }
        response.failure = { resp ->
          log.error("Error - ${resp}");
        }
      }
    }
    catch ( Exception e ) {
      e.printStackTrace();
    }

    result
  }
}
