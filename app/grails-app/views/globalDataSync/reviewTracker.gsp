<!doctype html>
<html>
  <head>
    <meta name="layout" content="mmbootstrap">
    <g:set var="entityName" value="${message(code: 'package.label', default: 'Package')}" />
    <title><g:message code="default.list.label" args="[entityName]" /></title>
  </head>
  <body>

    <div class="container">
      <div class="page-header">
        <h1>Track ${item.name}(${item.identifier}) from ${item.source.name}</h1>
      </div>
      <g:if test="${flash.message}">
        <bootstrap:alert class="alert-info">${flash.message}</bootstrap:alert>
      </g:if>
    </div>

    <g:form>
      <div class="container well">
        <h1>Review Tracker</h1>
        <g:if test="${type=='new'}">
          <p>This tracker will create a new local package for "${item.name}" from "${item.source.name}". Set the new package name below.</p>
          <dl>
            <dt>New Package Name</dt>
            <dd><input type="text" name="trackerName" value="${item.name}" class="input-xxlarge"/></dd>
          </dl>
        </g:if>
        <g:else>
          <p>This tracker will synchronize package "<b><em>${item.name}</em></b>" from "<b><em>${item.source.name}</em></b>" with the existing local package <b><em>${localPkg.name}</em></b> </p>
        </g:else>

        <dl>
          <td>Auto accept the following changes</dt>
          <dd>
          <table class="table">
            <tr>
              <td><input type="Checkbox" name="autoAcceptTippAddition"/>TIPP Addition</td>
              <td><input type="Checkbox" name="autoAcceptTippUpdate"/>TIPP Update</td>
              <td><input type="Checkbox" name="autoAcceptTippDelete"/>TIPP Delete</td>
              <td><input type="Checkbox" name="autoAcceptPackageChange"/>Package Changes</td>
            </tr>
          </table>
          </dd>
        </dl>
        <input type="submit"/>
      </div>
    </g:form>

    <div class="container well">
      <h1>Package Sync Impact</h1>
    </div>

  </body>
</html>
