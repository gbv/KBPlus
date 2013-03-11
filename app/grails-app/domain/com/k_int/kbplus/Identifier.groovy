package com.k_int.kbplus

class Identifier {

  IdentifierNamespace ns
  String value

  static hasMany = [ occurrences:IdentifierOccurrence ]
  static mappedBy = [ occurrences:'identifier' ]

  static constraints = {
  }

  static mapping = {
       id column:'id_id'
       ns column:'id_ns_fk', index:'id_value_idx'
    value column:'id_value', index:'id_value_idx'
  }

  static def lookupOrCreateCanonicalIdentifier(ns, value) {
    // log.debug("lookupOrCreateCanonicalIdentifier(${ns},${value})");
    def namespace = IdentifierNamespace.findByNs(ns) ?: new IdentifierNamespace(ns:ns).save();
    Identifier.findByNsAndValue(namespace,value) ?: new Identifier(ns:namespace, value:value).save();
  }

  static def refdataFind(params) {
    def result = [];
    def ql = null;
    if ( params.q.contains(':') ) {
      def qp=params.q.split(':');
      println("Search by namspace identifier: ${qp}");
      def namespace = IdentifierNamespace.findByNs(qp[0]);
      if ( namespace ) {
        ql = Identifier.findAllByNsAndValueLike(namespace,"${qp[1]}%")
      }
      else {
        println("No identifier... ${qp[0]}");
      }
    }
    else {
      ql = Identifier.findAllByValueLike("${params.q}%",params)
    }

    if ( ql ) {
      ql.each { id ->
        result.add([id:"${id.class.name}:${id.id}",text:"${id.ns.ns}:${id.value}"])
      }
    }

    result
  }

  static def refdataCreate(value) {
    def params = value.split(':');
    if ( ( params.length == 2 ) && ( params[0] != '' ) && ( params[1] != '' ) )
      return lookupOrCreateCanonicalIdentifier(params[0],params[1]);
  }

}
