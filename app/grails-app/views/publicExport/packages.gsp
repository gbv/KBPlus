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
 <br />
 To the extent possible under law,
 <a rel="dct:publisher"
    href="http://www.kbplus.ac.uk/exports">
   <span property="dct:title">JISC Collections</span></a>
 has waived all copyright and related or neighboring rights to
 <span property="dct:title">KBPlus Public Exports</span>.
This work is published from:
<span property="vcard:Country" datatype="dct:ISO3166"
     content="GB" about="www.kbplus.ac.uk/exports">
 United Kingdom</span>.
</p>
 <g:if test="${flash.message}">
      <bootstrap:alert class="alert-info">${flash.message}</bootstrap:alert>
  </g:if>

    <div class="container" style="text-align:center">
      <g:form action="packages" class="form-inline">
        <label>Package name : </label> <input type="text" name="q" placeholder="enter package name..." value="${params.q?.encodeAsHTML()}"  /> &nbsp;
       
        <input type="submit" class="btn btn-primary" value="Search" />
      </g:form><br/>
    </div>


    <div class="container">
        
      <table class="table table-bordered table-striped">
        <thead>
          <tr>
            <g:sortableColumn property="identifier" title="${message(code: 'package.identifier.label', default: 'Identifier')}" />
            <g:sortableColumn property="name" title="${message(code: 'package.name.label', default: 'Name')}" />
            <g:sortableColumn property="dateCreated" title="${message(code: 'package.dateCreated.label', default: 'Created')}" />
            <g:sortableColumn property="lastUpdated" title="${message(code: 'package.lastUpdated.label', default: 'Last Updated')}" />
            <th></th>
          </tr>
        </thead>
        <tbody>
          <g:each in="${packageInstanceList}" var="packageInstance">
            <tr>
              <td>${fieldValue(bean: packageInstance, field: "identifier")}</td>
              <td>${fieldValue(bean: packageInstance, field: "name")}</td>
              <td>${fieldValue(bean: packageInstance, field: "dateCreated")}</td>
              <td>${fieldValue(bean: packageInstance, field: "lastUpdated")}</td>
              <td class="link">
                <g:link action="pkg" id="${packageInstance.id}" class="btn btn-small">Show &raquo;</g:link>
              </td>
            </tr>
          </g:each>
        </tbody>
      </table>
      <div class="pagination">
        <bootstrap:paginate  action="list" controller="packageDetails" params="${params}" next="Next" prev="Prev" max="${max}" total="${packageInstanceTotal?:0}" />
      </div>

        </div>
      </div>
    </div>

  </body>

</html>
