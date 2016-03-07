<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<spring:eval expression="@propertyConfigurer.getProperty('url.cdn')" var="cdnUrl" />
<!DOCTYPE html>
<html lang="${language}">
<head>
    <meta charset="UTF-8">
    <title><spring:message code="voj.administration.problem-categories.title" text="Problem Categories" /> | ${websiteName}</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge, chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="${description}">
    <meta name="author" content="谢浩哲">
    <!-- Icon -->
    <link href="${cdnUrl}/img/favicon.ico" rel="shortcut icon" type="image/x-icon">
    <!-- StyleSheets -->
    <link rel="stylesheet" type="text/css" href="${cdnUrl}/css/bootstrap.min.css" />
    <link rel="stylesheet" type="text/css" href="${cdnUrl}/css/bootstrap-responsive.min.css" />
    <link rel="stylesheet" type="text/css" href="${cdnUrl}/css/flat-ui.min.css" />
    <link rel="stylesheet" type="text/css" href="${cdnUrl}/css/font-awesome.min.css" />
    <link rel="stylesheet" type="text/css" href="${cdnUrl}/css/administration/style.css" />
    <link rel="stylesheet" type="text/css" href="${cdnUrl}/css/administration/problem-categories.css" />
    <!-- JavaScript -->
    <script type="text/javascript" src="${cdnUrl}/js/jquery-1.11.1.min.js"></script>
    <script type="text/javascript" src="${cdnUrl}/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="${cdnUrl}/js/flat-ui.min.js"></script>
    <script type="text/javascript" src="${cdnUrl}/js/md5.min.js"></script>
    <script type="text/javascript" src="${cdnUrl}/js/pace.min.js"></script>
    <!--[if lte IE 9]>
        <script type="text/javascript" src="${cdnUrl}/js/jquery.placeholder.min.js"></script>
    <![endif]-->
    <!--[if lte IE 7]>
        <script type="text/javascript"> 
            window.location.href='<c:url value="/not-supported" />';
        </script>
    <![endif]-->
</head>
<body>
    <div id="wrapper">
        <!-- Sidebar -->
        <%@ include file="/WEB-INF/views/administration/include/sidebar.jsp" %>
        <div id="container">
            <!-- Header -->
            <%@ include file="/WEB-INF/views/administration/include/header.jsp" %>
            <!-- Content -->
            <div id="content">
                <h2 class="page-header"><i class="fa fa-th-list"></i> <spring:message code="voj.administration.problem-categories.problem-categories" text="Problem Categories" /></h2>
                <div class="row-fluid">
                    <div class="span4">
                        <h4><spring:message code="voj.administration.problem-categories.add-new-category" text="Add New Category" /></h4>
                        <form id="new-category-form" onSubmit="onSubmit(); return false;">
                            <div class="control-group row-fluid">
                                <label for="category-name"><spring:message code="voj.administration.problem-categories.category-name" text="Name" /></label>
                                <input id="category-name" class="span12" type="text" maxlength="32" />
                                <p><spring:message code="voj.administration.problem-categories.category-name-description" text="The name is how it appears on your site." /></p>
                            </div> <!-- .control-group -->
                            <div class="control-group row-fluid">
                                <label for="category-slug"><spring:message code="voj.administration.problem-categories.category-slug" text="Slug" /></label>
                                <input id="category-slug" class="span12" type="text" maxlength="32" />
                                <p><spring:message code="voj.administration.problem-categories.category-slug-description" text="The \"slug\" is the URL-friendly version of the name. It is usually all lowercase and contains only letters, numbers, and hyphens." /></p>
                            </div> <!-- .control-group -->
                            <div class="row-fluid">
                                <label for="category-parent"><spring:message code="voj.administration.problem-categories.category-parent" text="Parent" /></label>
                                <select id="category-parent">
                                    <option value=""><spring:message code="voj.administration.problem-categories.none" text="None" /></option>
                                <c:forEach items="${problemCategories}" var="problemCategory">
                                    <option value="${problemCategory.problemCategorySlug}">${problemCategory.problemCategoryName}</option>
                                </c:forEach>
                                </select>
                                <p><spring:message code="voj.administration.problem-categories.category-parent-description" text="Categories, unlike tags, can have a hierarchy. You might have a Search category, and under that have children categories for Breadth First Search and Deep First Search. Totally optional." /></p>
                            </div> <!-- .row-fluid -->
                            <div class="row-fluid">
                                <button class="btn btn-primary" type="submit"><spring:message code="voj.administration.problem-categories.add-new-category" text="Add New Category" /></button>
                            </div> <!-- .row-fluid -->
                        </form> <!-- #new-category-form -->
                    </div> <!-- .span4 -->
                    <div class="span8">
                        <table id="problem-categories" class="table table-striped">
                            <thead>
                                <tr>
                                    <th class="check-box">
                                        <label class="checkbox all-problem-categories" for="all-problem-categories-thead">
                                            <input id="all-problem-categories-thead" type="checkbox" data-toggle="checkbox">
                                        </label>
                                    </th>
                                    <th><spring:message code="voj.administration.problem-categories.category-name" text="Name" /></th>
                                    <th><spring:message code="voj.administration.problem-categories.category-slug" text="Slug" /></th>
                                </tr>
                            </thead>
                            <tbody>
                            <c:forEach items="${problemCategories}" var="problemCategory">
                                <tr  data-value="${problemCategory.problemCategoryId}">
                                    <td class="check-box">
                                        <label class="checkbox" for="problem-category-${problemCategory.problemCategorySlug}">
                                            <input id="problem-category-${problemCategory.problemCategorySlug}" type="checkbox" value="problem-category-${problemCategory.problemCategorySlug}" data-toggle="checkbox" />
                                        </label>
                                    </td>
                                    <td>
                                        <span class="problem-category-name">${problemCategory.problemCategoryName}</span>
                                        <input type="hidden" class="parent-category" value="${problemCategory.parentProblemCategoryId}" />
                                        <ul class="actions inline">
                                            <li><a href="javascript:void(0);" class="action-edit"><spring:message code="voj.administration.problem-categories.edit" text="Edit" /></a></li>
                                        <c:if test="${problemCategory.problemCategorySlug != 'uncategorized'}">
                                            <li><a href="javascript:void(0);" class="action-delete"><spring:message code="voj.administration.problem-categories.delete" text="Delete" /></a></li>
                                        </c:if>
                                        </ul>
                                    </td>
                                    <td><span class="problem-category-slug">${problemCategory.problemCategorySlug}</span></td>
                                </tr>
                            </c:forEach>
                            </tbody>
                            <tfoot>
                                <tr>
                                    <th class="check-box">
                                        <label class="checkbox all-problem-categories" for="all-problem-categories-tfoot">
                                            <input id="all-problem-categories-tfoot" type="checkbox" data-toggle="checkbox">
                                        </label>
                                    </th>
                                    <th><spring:message code="voj.administration.problem-categories.category-name" text="Name" /></th>
                                    <th><spring:message code="voj.administration.problem-categories.category-slug" text="Slug" /></th>
                                </tr>
                            </tfoot>
                        </table>
                    </div> <!-- .span8 -->
                </div> <!-- .row-fluid -->
            </div> <!-- #content -->
        </div> <!-- #container -->
    </div> <!-- #wrapper -->
    <!-- Java Script -->
    <!-- Placed at the end of the document so the pages load faster -->
    <%@ include file="/WEB-INF/views/administration/include/footer-script.jsp" %>
    <script type="text/javascript">
        // Global Variable for Problem Categories Store
        // Key: ID for the ProblemCategory
        // Value: the ProblemCategory object
        problemCategoriesOptions = {
            "0": {
                "problemCategorySlug": "none",
                "problemCategoryName": "<spring:message code="voj.administration.problem-categories.none" text="None" />"
            }
        <c:forEach items="${problemCategories}" var="problemCategory">
            , "${problemCategory.problemCategoryId}": {
                "problemCategorySlug": "${problemCategory.problemCategorySlug}",
                "problemCategoryName": "${problemCategory.problemCategoryName}"
            }
        </c:forEach>
        };
    </script>
    <script type="text/javascript">
        $('label.all-problem-categories').click(function() {
            // Fix the bug for Checkbox in FlatUI 
            var isChecked = false,
                trigger   = $(this);
            setTimeout(function() {
                isChecked = $(trigger).hasClass('checked');
                
                if ( isChecked ) {
                    $('label.checkbox').addClass('checked');
                } else {
                    $('label.checkbox').removeClass('checked');
                }
            }, 100);
        });
    </script>
    <script type="text/javascript">
        $('tr', '#problem-categories').hover(function() {
            $('ul.actions', $(this)).css('visibility', 'visible');
        }, function() {
            $('ul.actions', $(this)).css('visibility', 'hidden');
        });
    </script>
    <script type="text/javascript">
        $('.action-edit').click(function() {
            var currentRowSet           = $(this).parent().parent().parent().parent(),
                problemCategoryId       = $(currentRowSet).attr('data-value'),
                problemCategoryName     = $('.problem-category-name', $(currentRowSet)).html(),
                problemCategorySlug     = $('.problem-category-slug', $(currentRowSet)).html(),
                parentProblemCategoryId = $('.parent-category', $(currentRowSet)).val();

            $('.edit-fieldset').remove();
            $('tr.hide', '#problem-categories').removeClass('hide');
            $(currentRowSet).addClass('hide');

            $(currentRowSet).after(getEditFieldset(problemCategoryId, problemCategoryName, problemCategorySlug));
            $('#category-parent-edit').append(getParentProblemCategoriesOptions());
            $('#category-parent-edit option[value=%s]'.format(problemCategorySlug), '.edit-fieldset').remove();
            $('#category-parent-edit', '.edit-fieldset').val(getProblemCategorySlugUsingId(parentProblemCategoryId));

            if ( problemCategorySlug == 'uncategorized' ) {
                $('#category-slug-edit', '.edit-fieldset').attr('disabled', 'disabled');
                $('#category-parent-edit', '.edit-fieldset').attr('disabled', 'disabled');
            }
        });
    </script>
    <script type="text/javascript">
        function getProblemCategorySlugUsingId(problemCategoryId) {
            for (var key in problemCategoriesOptions) {
                var problemCategory = problemCategoriesOptions[key];

                if ( key == problemCategoryId &&
                     problemCategoriesOptions.hasOwnProperty(key) ) {
                    return problemCategory['problemCategorySlug'];
                }
            }
            return 'none';
        }
    </script>
    <script type="text/javascript">
        function getEditFieldset(problemCategoryId, problemCategoryName, problemCategorySlug) {
            var tpl =  '<tr class="edit-fieldset" data-value="%s">' +
                       '    <td colspan="3">' +
                       '        <div class="control-group row-fluid">' +
                       '            <label for="category-name-edit"><spring:message code="voj.administration.problem-categories.category-name" text="Name" /></label>' +
                       '            <input id="category-name-edit" class="span12" type="text" value="%s" maxlength="32" />' +
                       '        </div> <!-- .control-group -->' +
                       '        <div class="control-group row-fluid">' +
                       '            <label for="category-slug-edit"><spring:message code="voj.administration.problem-categories.category-slug" text="Slug" /></label>' +
                       '            <input id="category-slug-edit" class="span12" type="text"  value="%s" maxlength="32" />' +
                       '        </div> <!-- .control-group -->' +
                       '        <div class="row-fluid">' +
                       '            <label for="category-parent-edit"><spring:message code="voj.administration.problem-categories.category-parent" text="Parent" /></label>' +
                       '            <select id="category-parent-edit">' +
                       '            </select>' +
                       '        </div> <!-- .row-fluid -->' +
                       '        <div class="row-fluid">' +
                       '            <button class="btn btn-cancel"><spring:message code="voj.administration.problem-categories.cancel" text="Cancel" /></button>' +
                       '            <button class="btn btn-primary pull-right" type="submit"><spring:message code="voj.administration.problem-categories.update-category" text="Update Category" /></button>' +
                       '        </div> <!-- .row-fluid -->' +
                       '    </td>' +
                       '</tr>';
            return tpl.format(problemCategoryId, problemCategoryName, problemCategorySlug);
        }
    </script>
    <script type="text/javascript">
        $('#problem-categories').delegate('.edit-fieldset .btn-cancel', 'click', function() {
            $('.edit-fieldset').remove();
            $('tr.hide', '#problem-categories').removeClass('hide');
        });
    </script>
    <script type="text/javascript">
        $('#problem-categories').delegate('.edit-fieldset .btn-primary', 'click', function() {
            var problemCategoryId       = $(this).parent().parent().parent().attr('data-value'),
                problemCategorySlug     = $('#category-slug-edit', $(this).parent().parent()).val(),
                problemCategoryName     = $('#category-name-edit', $(this).parent().parent()).val(),
                parentProblemCategory   = $('#category-parent-edit', $(this).parent().parent()).val();

            $('.edit-fieldset .btn-primary', '#problem-categories').attr('disabled', 'disabled');
            $('.edit-fieldset .btn-primary', '#problem-categories').html('<spring:message code="voj.administration.problem-categories.please-wait" text="Please wait..." />');

            return doEditProblemCategoryAction(problemCategoryId, problemCategorySlug, 
                    problemCategoryName, parentProblemCategory);
        });
    </script>
    <script type="text/javascript">
        function doEditProblemCategoryAction(problemCategoryId, problemCategorySlug, 
            problemCategoryName, parentProblemCategory) {
            var postData = {
                'problemCategoryId': problemCategoryId,
                'problemCategorySlug': problemCategorySlug,
                'problemCategoryName': problemCategoryName,
                'parentProblemCategory': parentProblemCategory
            };

            $.ajax({
                type: 'POST',
                url: '<c:url value="/administration/editProblemCategory.action" />',
                data: postData,
                dataType: 'JSON',
                success: function(result){
                    return processEditProblemCategoryResult(result);
                }
            });
        }
    </script>
    <script type="text/javascript">
        function processEditProblemCategoryResult(result) {
            console.log(result);

            $('.edit-fieldset .btn-primary', '#problem-categories').removeAttr('disabled');
            $('.edit-fieldset .btn-primary', '#problem-categories').html('<spring:message code="voj.administration.problem-categories.add-new-category" text="Add New Category" />');
        }
    </script>
    <script type="text/javascript">
        $('.action-delete').click(function() {
            var currentRowSet           = $(this).parent().parent().parent().parent(),
                problemCategorySlug     = $('.problem-category-slug', $(currentRowSet)).html(),
                parentProblemCategoryId = $('.parent-category', $(currentRowSet)).val();

            $(currentRowSet).remove();
        });
    </script>
    <script type="text/javascript">
        function doDeleteProblemCategoryAction() {
            // TODO
        }
    </script>
    <script type="text/javascript">
        function onSubmit() {
            var problemCategorySlug     = $('#category-slug').val(),
                problemCategoryName     = $('#category-name').val(),
                parentProblemCategory   = $('#category-parent').val();

            $('.alert-success', '#new-category-form').addClass('hide');
            $('.alert-error', '#new-category-form').addClass('hide');
            $('button[type=submit]', '#new-category-form').attr('disabled', 'disabled');
            $('button[type=submit]', '#new-category-form').html('<spring:message code="voj.administration.problem-categories.please-wait" text="Please wait..." />');

            return doCreateProblemCategoryAction(problemCategorySlug, problemCategoryName, parentProblemCategory);
        }
    </script>
    <script type="text/javascript">
        function doCreateProblemCategoryAction(problemCategorySlug, problemCategoryName, parentProblemCategory) {
            var postData = {
                'problemCategorySlug': problemCategorySlug,
                'problemCategoryName': problemCategoryName,
                'parentProblemCategory': parentProblemCategory
            };

            $.ajax({
                type: 'POST',
                url: '<c:url value="/administration/createProblemCategory.action" />',
                data: postData,
                dataType: 'JSON',
                success: function(result){
                    return processCreateProblemCategoryResult(result);
                }
            });
        }
    </script>
    <script type="text/javascript">
        function processCreateProblemCategoryResult(result) {
            if ( result['isSuccessful'] ) {
                window.location.reload();
            } else {
                // TODO
            }

            $('button[type=submit]', '#new-category-form').removeAttr('disabled');
            $('button[type=submit]', '#new-category-form').html('<spring:message code="voj.administration.problem-categories.add-new-category" text="Add New Category" />');
        }
    </script>
    <script type="text/javascript">
        function getParentProblemCategoriesOptions() {
            var options = '';

            for (var problemCategoryId in problemCategoriesOptions) {
                var problemCategory = problemCategoriesOptions[problemCategoryId];

                if ( problemCategoriesOptions.hasOwnProperty(problemCategoryId) ) {
                    options += '<option value="%s">%s</option>'.format(
                        problemCategory['problemCategorySlug'], 
                        problemCategory['problemCategoryName']
                    );
                }
            }
            return options;
        }
    </script>
</body>
</html>