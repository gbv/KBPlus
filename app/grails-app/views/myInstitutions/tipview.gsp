<!doctype html>
<html>
  <head>
    <meta name="layout" content="mmbootstrap"/>
    <title>KB+ ${institution.name} - Edit Core Titles</title>
  </head>

  <body>
    <div class="container">

    <div class="container">
      <ul class="breadcrumb">
        <li> <g:link controller="home" action="index">Home</g:link> <span class="divider">/</span> </li>
        <li> <g:link controller="myInstitutions" action="tipview" params="${[shortcode:params.shortcode]}">${institution.name} Edit Core Titles </g:link> </li>
      </ul>
    </div>

    </div>
      <div class="container">

    
      <g:if test="${flash.message}">
      <bootstrap:alert class="alert-info">${flash.message}</bootstrap:alert>
      </g:if>
        <g:if test="${flash.error}">
        <bootstrap:alert class="alert alert-error">${flash.error}</bootstrap:alert>
      </g:if>

      <div class="row">
        <div class="span12">
          <g:form action="tipview" method="get" params="${params}">
          <input type="hidden" name="offset" value="${params.offset}"/>

          <div class="well form-horizontal">
            Search For: <select name="search_for">
                                <option ${params.search_for=='title' ? 'selected' : ''} value="title">Title</option>
                    <option ${params.search_for=='provider' ? 'selected' : ''} value="provider">Provider</option>
                    </select>
            Name: <input name="search_str" placeholder="Partial terms accepted" value="${params.search_str}"/>
            Sort: <select name="sort">
                    <option ${params.sort=='title-title' ? 'selected' : ''} value="title-title">Title</option>
                    <option ${params.sort=='provider-name' ? 'selected' : ''} value="provider-name">Provider</option>
                  </select>
            Order: <select name="order" value="${params.order}">
                    <option ${params.order=='asc' ? 'selected' : ''} value="asc">Ascending</option>
                    <option ${params.order=='desc' ? 'selected' : ''} value="desc">Descending</option>
                  </select>
            <button type="submit" name="search" value="yes">Search</button>
          </div>
          </g:form>
        </div>
      </div>


        <table class="table table-bordered table-striped">
          <thead>
            <tr>
              <th>Title</th>
              <th>Provider</th>
              <th></th>
            </tr>
          </thead>
          <tbody>
          <g:each in="${tips}" var="tip">
            <tr>
                        
              <td>
              <g:link controller="titleDetails" action="show" id="${tip?.title?.id}">${tip?.title?.title}</g:link>
              </td>   
              <td>
              <g:link controller="org" action="show" id="${tip?.provider?.id}">${tip?.provider?.name}</g:link>
              </td>   
              <td class="link">
                <button onclick="showDetails(${tip.id});" class="btn btn-small">Edit Dates</button>
              </td>
            </tr>
          </g:each>
          </tbody>
        </table>
          <div class="paginateButtons" style="text-align:center">
          <span><g:paginate action="tipview" params="${params}" next="Next" prev="Prev" total="${tips.totalCount}" /></span>
          </div>
        <div id="magicArea">
        </div>
        </div>

        <g:javascript>
        function showDetails(id){
          console.log(${editable});
          jQuery.ajax({type:'get', url:"${createLink(controller:'ajax', action:'getTipCoreDates')}?editable="+${editable}+"&tipID="+id,success:function(data,textStatus){jQuery('#magicArea').html(data);$('div[name=coreAssertionEdit]').modal("show")},error:function(XMLHttpRequest,textStatus,errorThrown){}
        });
        }

         function hideModal(){
          $("[name='coreAssertionEdit']").modal('hide');
         }

        function showCoreAssertionModal(){
          $("input.datepicker-class").datepicker({
            format:"${session.sessionPreferences?.globalDatepickerFormat}"
          });
          $("[name='coreAssertionEdit']").modal('show');
          $('.xEditableValue').editable();
        }
        </g:javascript>

  </body>
</html>     