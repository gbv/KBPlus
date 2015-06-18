<%@ page import="com.k_int.kbplus.Package" %>
<!doctype html>
<html>
  <head>
    <meta name="layout" content="mmbootstrap">
    <title>${ti.title}</title>
  </head>
  <body>
      <div class="container">
        <div class="row">
          <div class="span12">

            <div class="page-header">
              <h1><g:if test="${editable}"><span id="titleEdit" 
                        class="xEditableValue"
                        data-type="textarea" 
                        data-pk="${ti.class.name}:${ti.id}"
                        data-name="title" 
                        data-url='<g:createLink controller="ajax" action="editableSetValue"/>'
                        data-original-title="${ti.title}">${ti.title}</span></g:if><g:else>${ti.title}</g:else></h1>
            </div>

            <g:if test="${flash.message}">
            <bootstrap:alert class="alert-info">${flash.message}</bootstrap:alert>
            </g:if>



             <g:hasErrors bean="${flash.domainError}">
                    <bootstrap:alert class="alert-error">
                    <ul>
                        <g:eachError bean="${flash.domainError}" var="error">
                            <li> <g:message error="${error}"/></li>
                        </g:eachError>
                    </ul>
                    </bootstrap:alert>
              </g:hasErrors>



            <g:if test="${flash.error}">
            <bootstrap:alert class="alert-info">${flash.error}</bootstrap:alert>
            </g:if>

            <h3>Identifiers</h3>
            <table class="table table-bordered">
              <thead>
                <tr>
                  <th>ID</td>
                  <th>Identifier Namespace</th>
                  <th>Identifier</th>
                  <th>Actions</th>
                </tr>
              </thead>
              <tbody>
                <g:each in="${ti.ids}" var="io">
                  <tr>
                    <td>${io.id}</td>
                    <td>${io.identifier.ns.ns}</td>
                    <g:if test="${io.identifier.ns.ns == 'zdbid'}">
                    <td><a href="http://ld.zdb-services.de/data/${io.identifier.value}.html">
                    ${io.identifier.value}</a></td></g:if>
                    <g:else><td>${io.identifier.value}</td></g:else>
                    <td><g:if test="${editable}"><g:link controller="ajax" action="deleteThrough" params='${[contextOid:"${ti.class.name}:${ti.id}",contextProperty:"ids",targetOid:"${io.class.name}:${io.id}"]}'>Delete Identifier</g:link></g:if></td>
                  </tr>
                </g:each>
              </tbody>
            </table>

           
            <g:if test="${editable}">
              <g:form controller="ajax" action="addToCollection" class="form-inline">
                Select an existing identifer using the typedown, or create a new one by entering namespace:value (EG eISSN:2190-9180) then clicking that value in the dropdown to confirm.<br/>
                <input type="hidden" name="__context" value="${ti.class.name}:${ti.id}"/>
                <input type="hidden" name="__newObjectClass" value="com.k_int.kbplus.IdentifierOccurrence"/>
                <input type="hidden" name="__recip" value="ti"/>
                <input type="hidden" name="identifier" id="addIdentifierSelect"/>
                <input type="submit" value="Add Identifier..." class="btn btn-primary btn-small"/><br/>
              </g:form>
            </g:if>
            <h3>Org Links</h3>

          <g:render template="orgLinks" contextPath="../templates" model="${[roleLinks:ti?.orgs,editmode:editable]}" />

          </div>
        </div>

        <div class="row">
          <div class="span12">


            <h3>Appears in...</h3>
            <table class="table table-bordered table-striped">
                    <tr>
                        <th>From Date</th><th>From Volume</th><th>From Issue</th>
                        <th>To Date</th><th>To Volume</th><th>To Issue</th><th>Coverage Depth</th>
                        <th>Platform</th><th>Package</th><th>Actions</th>
                    </tr>
                    <g:each in="${ti.tipps}" var="t">
                        <tr>
                            <td><g:formatDate format="${session.sessionPreferences?.globalDateFormat}" date="${t.startDate}"/></td>
                        <td>${t.startVolume}</td>
                        <td>${t.startIssue}</td>
                        <td><g:formatDate format="${session.sessionPreferences?.globalDateFormat}" date="${t.endDate}"/></td>
                        <td>${t.endVolume}</td>
                        <td>${t.endIssue}</td>
                        <td>${t.coverageDepth}</td>
                        <td><g:link controller="platform" action="show" id="${t.platform.id}">${t.platform.name}</g:link></td>
                        <td><g:link controller="packageDetails" action="show" id="${t.pkg.id}">${t.pkg.name}</g:link></td>
                        <td><g:link controller="tipp" action="show" id="${t.id}">Full TIPP record</g:link></td>
                        </tr>
                    </g:each>
            </table>

          </div>
        </div>



      </div>

    <g:render template="orgLinksModal" 
              contextPath="../templates" 
              model="${[linkType:ti?.class?.name,roleLinks:ti?.orgs,parent:ti.class.name+':'+ti.id,property:'orgLinks',recip_prop:'title']}" />

  <r:script language="JavaScript">

    $(function(){
      // moved to mm_bootstrap
      // $.fn.editable.defaults.mode = 'inline';
      // $('.xEditableValue').editable();

      <g:if test="${editable}">
      $("#addIdentifierSelect").select2({
        placeholder: "Search for an identifier...",
        minimumInputLength: 1,
        ajax: { // instead of writing the function to execute the request we use Select2's convenient helper
          url: "<g:createLink controller='ajax' action='lookup'/>",
          dataType: 'json',
          data: function (term, page) {
              return {
                  q: term, // search term
                  page_limit: 10,
                  baseClass:'com.k_int.kbplus.Identifier'
              };
          },
          results: function (data, page) {
            return {results: data.values};
          }
        },
        createSearchChoice:function(term, data) {
          return {id:'com.k_int.kbplus.Identifier:__new__:'+term,text:term};
        }
      });

      $("#addOrgSelect").select2({
        placeholder: "Search for an org...",
        minimumInputLength: 1,
        ajax: { // instead of writing the function to execute the request we use Select2's convenient helper
          url: "<g:createLink controller='ajax' action='lookup'/>",
          dataType: 'json',
          data: function (term, page) {
              return {
                  q: term, // search term
                  page_limit: 10,
                  baseClass:'com.k_int.kbplus.Org'
              };
          },
          results: function (data, page) {
            return {results: data.values};
          }
        }
      });

      $("#orgRoleSelect").select2({
        placeholder: "Search for an role...",
        minimumInputLength: 1,
        ajax: { // instead of writing the function to execute the request we use Select2's convenient helper
          url: "<g:createLink controller='ajax' action='lookup'/>",
          dataType: 'json',
          data: function (term, page) {
              return {
                  q: term, // search term
                  page_limit: 10,
                  baseClass:'com.k_int.kbplus.RefdataValue'
              };
          },
          results: function (data, page) {
            return {results: data.values};
          }
        }
      });
      </g:if>



    });

    function validateAddOrgForm() {
      var org_name=$("#addOrgSelect").val();
      var role=$("#orgRoleSelect").val();

      if( !org_name || !role ){
        return false;
      }
      return true;
    }
  </r:script>

  </body>
</html>
