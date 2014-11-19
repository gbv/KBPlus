<!doctype html>

<!--[if lt IE 7]> <html class="no-js lt-ie9 lt-ie8 lt-ie7" lang="en"> <![endif]-->
<!--[if IE 7]>    <html class="no-js lt-ie9 lt-ie8" lang="en"> <![endif]-->
<!--[if IE 8]>    <html class="no-js lt-ie9" lang="en"> <![endif]-->
<!--[if gt IE 8]><!--> <html class="no-js" lang="en"> <!--<![endif]-->

  <head>
    <meta name="layout" content="pubbootstrap"/>
    <title>KB+ Public Package List</title>
  </head>


  <body class="public">

  <g:render template="public_navbar" contextPath="/templates" model="['active': 'publicExport']"/>


  <div class="container">
    <h1>Packages</h1>
  </div>

    <div class="container">
      <div class="row">
        <div class="span12">

          <p xmlns:dct="http://purl.org/dc/terms/" xmlns:vcard="http://www.w3.org/2001/vcard-rdf/3.0#">
            <a rel="license" href="http://creativecommons.org/publicdomain/zero/1.0/"><img src="http://creativecommons.org/images/deed/nolaw.png" style="border-style: none;" alt="CC0" /></a>
            <br /> To the extent possible under law, <a rel="dct:publisher" href="http://www.kbplus.ac.uk/exports"> <span property="dct:title">JISC Collections</span></a> has waived all copyright and related or neighboring rights to <span property="dct:title">KBPlus Public Exports</span>.  This work is published from: <span property="vcard:Country" datatype="dct:ISO3166" content="GB" about="www.kbplus.ac.uk/exports"> United Kingdom</span>.  </p>


 <g:if test="${flash.message}">
      <bootstrap:alert class="alert-info">${flash.message}</bootstrap:alert>
  </g:if>

    <div class="container">
        
      <table class="table table-bordered table-striped">
        <thead>
          <tr>
            <th>Title</th>
            <th>Platform</th>
            <th>Identifiers</th>
            <th>Coverage Start</th>
            <th>Coverage End</th>
            <th>Coverage Depth</th>
          </tr>
        </thead>
        <tbody>
          <g:each in="${tipps}" var="tipp">
            <tr>
              <td>${tipp.title.title}</td>
              <td>${tipp.platform.name}</td>
              <td><g:each in="${tipp.title.ids}">${it.identifier.value}<br/></g:each></td>
              <td>Date: <g:formatDate date="${tipp.startDate}" format="yyyy-MM-dd"/> <br/>Volume:${tipp.startVolume} <br/>Issue:${tipp.startIssue}</td>
              <td>Date: <g:formatDate date="${tipp.endDate}" format="yyyy-MM-dd"/> <br/>Volume:${tipp.endVolume} <br/>Issue:${tipp.endIssue}</td>
              <td>${tipp.coverageDepth}</td>
            </tr>
          </g:each>
        </tbody>
      </table>

    </div>
      </div>
    </div>
    </div>

  </body>

</html>
