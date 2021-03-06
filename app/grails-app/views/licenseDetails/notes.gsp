<!doctype html>
<html>
    <head>
        <meta name="layout" content="mmbootstrap"/>
        <title>KB+ Licence</title>
</head>

<body>

    <div class="container">
      <ul class="breadcrumb">
        <li> <g:link controller="home" action="index">Home</g:link> <span class="divider">/</span> </li>
        <g:if test="${license.licensee}">
          <li> <g:link controller="myInstitutions" action="currentLicenses" params="${[shortcode:license.licensee.shortcode]}"> ${license.licensee.name} Current Licences</g:link> <span class="divider">/</span> </li>
        </g:if>
        <li> <g:link controller="licenseDetails" action="index" id="${params.id}">Licence Details</g:link> <span class="divider">/</span></li>
        <li> <g:link controller="licenseDetails" action="notes" id="${params.id}">Licence Notes</g:link> </li>

        <g:if test="${editable}">
          <li class="pull-right">Editable by you&nbsp;</li>
        </g:if>

      </ul>
    </div>

    <div class="container">
        <h1>${license.licensee?.name} ${license.type?.value} Licence : <span id="reference" style="padding-top: 5px;">${license.reference}</span></h1>

<g:render template="nav" />

    </div>

    <div class="container">
        <g:render template="/templates/notes_table" model="${[instance: license, redirect: 'notes']}"/>

    </div>
<g:render template="/templates/addNote"
          model="${[doclist: license.documents, ownobj: license, owntp: 'license']}"/>

</body>
</html>
