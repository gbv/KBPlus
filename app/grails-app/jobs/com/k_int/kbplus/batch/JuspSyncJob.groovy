package com.k_int.kbplus.batch

class JuspSyncJob {

  def juspSyncService

  static triggers = {
    // Delay 20 seconds, run every 10 mins.
    // Cron:: Min Hour DayOfMonth Month DayOfWeek Year
    // Example - every 10 mins 0 0/10 * * * ? 
    // At 5 past 2am on the first of every month - Sync JUSP Stats
    cron name:'juspSyncTrigger', startDelay:20000, cronExpression: "0 5 2 1 * ?"
   // cronExpression: "s m h D M W Y"
   //                  | | | | | | `- Year [optional]
   //                  | | | | | `- Day of Week, 1-7 or SUN-SAT, ?
   //                  | | | | `- Month, 1-12 or JAN-DEC
   //                  | | | `- Day of Month, 1-31, ?
   //                  | | `- Hour, 0-23
   //                  | `- Minute, 0-59
   //                  `- Second, 0-59
  }

  def execute() {
    log.debug("Execute::JuspSyncJob");
    if ( ApplicationHolder.application.config.KBPlusMaster == true ) {
      log.debug("This server is marked as KBPlus master. Running JUSP SYNC batch job");
      juspSyncService.doSync()
    }
    else {
      log.debug("This server is NOT marked as KBPlus master. NOT Running JUSP SYNC batch job");
    }
  }

}
