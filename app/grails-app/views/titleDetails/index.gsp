<!doctype html>
<html>
  <head>
    <meta name="layout" content="mmbootstrap"/>
    <title>KB+ Titles - Search</title>
  </head>

  <body>


    <div class="container">
      <ul class="breadcrumb">
        <li><g:link controller="home" action="index">Home</g:link> <span class="divider">/</span></li>
        <li><g:link controller="titleDetails" action="index">All Titles</g:link></li>
      </ul>
    </div>

    <div class="container">
      <g:form action="index" method="get" params="${params}">
      <input type="hidden" name="offset" value="${params.offset}"/>

      <div class="row">
        <div class="span12">
          <div class="well">
            Title : <input name="q" placeholder="Add &quot;&quot; for exact match" value="${params.q}"/> (Search on title text and identifiers)
            <button type="submit" name="search" value="yes">Search</button>
            <div class="pull-right">
            </div>
          </div>
        </div>
      </div>


      <div class="row">

        <div class="span12">
          <div class="well">
             <g:if test="${hits}" >
                <div class="paginateButtons" style="text-align:center">
                  <g:if test="${params.int('offset')}">
                   Showing Results ${params.int('offset') + 1} - ${hits.totalHits < (params.int('max') + params.int('offset')) ? hits.totalHits : (params.int('max') + params.int('offset'))} of ${hits.totalHits}
                  </g:if>
                  <g:elseif test="${hits.totalHits && hits.totalHits > 0}">
                    Showing Results 1 - ${hits.totalHits < params.int('max') ? hits.totalHits : params.int('max')} of ${hits.totalHits}
                  </g:elseif>
                  <g:else>
                    Showing ${hits.totalHits} Results
                  </g:else>
                </div>

                <div id="resultsarea">
                  <table class="table table-bordered table-striped">
                    <thead>
                      <tr>
                      <th style="white-space:nowrap">Title</th>
                      <th style="white-space:nowrap">Publisher</th>
                      <th style="white-space:nowrap">Identifiers</th>
                      </tr>
                    </thead>
                    <tbody>
                      <g:each in="${hits}" var="hit">
                        <tr>
                          <td>
                            <g:link controller="titleDetails" action="show" id="${hit.source.dbId}">${hit.source.title}</g:link>
                            <g:if test="${editable}">
                              <g:link controller="titleDetails" action="edit" id="${hit.source.dbId}">(Edit)</g:link>
                            </g:if>
                          </td>
                          <td>
                            ${hit.source.publisher?:''}
                          </td>
                          <td>
                            <g:each in="${hit.source.identifiers}" var="id">
                              <g:if test="${id.type == 'zdbid'}">
                                <a href="http://ld.zdb-services.de/data/${id.value}.html">${id.type}:${id.value}</a><br/>
                              </g:if><g:else>
                                ${id.type}:${id.value}<br/>
                              </g:else>
                            </g:each>
                          </td>
                        </tr>
                      </g:each>
                    </tbody>
                  </table>
                </div>
             </g:if>
             <div class="paginateButtons" style="text-align:center">
                <g:if test="${hits}" >
                  <span><g:paginate controller="titleDetails" action="index" params="${params}" next="Next" prev="Prev" maxsteps="10" total="${hits.totalHits}" /></span>
                </g:if>
              </div>
          </div>
        </div>
      </div>
      </g:form>
    </div>
    <!-- ES Query: ${es_query} -->
  </body>
</html>
