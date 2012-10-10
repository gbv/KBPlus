package com.k_int.kbplus

class TitleInstancePackagePlatform {

  Date startDate
  String rectype="so"
  String startVolume
  String startIssue
  Date endDate
  String endVolume
  String endIssue
  String embargo
  String coverageDepth
  String coverageNote
  String impId
  RefdataValue status
  RefdataValue option
  String hostPlatformURL

  TitleInstancePackagePlatform derivedFrom

  static mappedBy = [ids: 'tipp', additionalPlatforms: 'tipp']
  static hasMany = [ids: IdentifierOccurrence, 
                    additionalPlatforms: PlatformTIPP]


  static belongsTo = [
    pkg:Package,
    platform:Platform,
    title:TitleInstance,
    sub:Subscription
  ]

  static mapping = {
               id column:'tipp_id'
          rectype column:'tipp_rectype'
          version column:'tipp_version'
              pkg column:'tipp_pkg_fk', index: 'tipp_idx'
         platform column:'tipp_plat_fk', index: 'tipp_idx'
            title column:'tipp_ti_fk', index: 'tipp_idx'
        startDate column:'tipp_start_date'
      startVolume column:'tipp_start_volume'
       startIssue column:'tipp_start_issue'
          endDate column:'tipp_end_date'
        endVolume column:'tipp_end_volume'
         endIssue column:'tipp_end_issue'
          embargo column:'tipp_embargo'
    coverageDepth column:'tipp_coverage_depth'
     coverageNote column:'tipp_coverage_note',type: 'text'
            impId column:'tipp_imp_id', index: 'tipp_imp_id_idx'
           status column:'tipp_status_rv_fk'
           option column:'tipp_option_rv_fk'
  hostPlatformURL column:'tipp_host_platform_url'
              sub column:'tipp_sub_fk'
      derivedFrom column:'tipp_derived_from'
  }

  static constraints = {
    startDate(nullable:true, blank:true);
    startVolume(nullable:true, blank:true);
    startIssue(nullable:true, blank:true);
    endDate(nullable:true, blank:true);
    endVolume(nullable:true, blank:true);
    endIssue(nullable:true, blank:true);
    embargo(nullable:true, blank:true);
    coverageDepth(nullable:true, blank:true);
    coverageNote(nullable:true, blank:true);
    impId(nullable:true, blank:true);
    status(nullable:true, blank:false);
    option(nullable:true, blank:false);
    sub(nullable:true, blank:false);
    hostPlatformURL(nullable:true, blank:true);
    derivedFrom(nullable:true, blank:true);
  }

  
  def getHostPlatform() {
    def result = null;
    additionalPlatforms.each { p ->
      if ( p.rel == 'host' ) {
        result = p.titleUrl
      }
    }
    result
  }
}
