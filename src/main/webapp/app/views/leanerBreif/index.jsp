<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>Title</title>
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
  <script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>
</head>
<body>
<div id="toast-success" class="absolute right-2 -top-2 flex items-center p-4 mb-4 w-full max-w-xs text-gray-500 rounded-lg shadow" role="alert"></div>
<div class="p-6 mt-8">
  <div class="overflow-x-auto relative sm:rounded-lg px-6">
    <div id="dataUser-data"></div>
    <div id="allBreifs" class="grid grid-cols-3 gap-2">
       <%--     start card breif--%>

        <%--     end card breif--%>
    </div>
  </div>
</div>
<script>
  // hide elemment when loading page
  $("#toast-success").hide()
  $("#dataUser-data").hide()
  // get all breifs specific learner
  getAllBreifs()
  function getAllBreifs() {
    let element = '<div class="flex justify-center overflow-hidden"><div class="mx-auto mt-10 w-8 h-8 border-4 border-dashed rounded-full animate-spin dark:border-violet-400"></div></div>'
    $("#dataUser-data").html(element)
    $("#dataUser-data").show()
    $.ajax({
      url  : "/learner/get-breifs",
      type : "get",
      success : function (response){
       console.log(response)
       let stringHtml = ''
       const breifs = JSON.parse(response)
       for (const breif of breifs) {
         stringHtml += '<div class="max-w-sm bg-white rounded-lg border border-gray-200 shadow-md">'
         stringHtml += '<a href="/learner/breifs-description?id='+breif[0]+'">'
         stringHtml += '<img id="image-breif" class="rounded-t-lg w-full h-48 border" src="${pageContext.request.contextPath}/assets/images/'+breif[4]+'" alt="" /></a>'
         stringHtml += ' <div class="p-5">'
         stringHtml += '<a href="/learner/breifs-description?id='+breif[0]+'">'
         stringHtml += '<h5 id="title" class="mb-2 text-1xl font-bold tracking-tight text-gray-900">'+breif[1]+'</h5>'
         stringHtml += '</a>'
         stringHtml += '<p id="description" class="mb-3 font-normal text-gray-700">'+breif[2].substring(0,100)+'...</p>'
         stringHtml += '<a href="/learner/breifs-description?id='+breif[0]+'"> <button class="inline-flex items-center py-2 px-3 text-sm font-medium text-center text-white bg-[#14BDEE] rounded-lg focus:ring-4 focus:outline-none focus:ring-blue-300">Read more'
         stringHtml += '<svg aria-hidden="true" class="ml-2 -mr-1 w-4 h-4" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg"><path fill-rule="evenodd" d="M10.293 3.293a1 1 0 011.414 0l6 6a1 1 0 010 1.414l-6 6a1 1 0 01-1.414-1.414L14.586 11H3a1 1 0 110-2h11.586l-4.293-4.293a1 1 0 010-1.414z" clip-rule="evenodd"></path></svg>'
         stringHtml += '</button></a>'
         stringHtml += '</div></div>'
       }
        $("#dataUser-data").hide()
        $("#allBreifs").html(stringHtml)
      },
      error : function (error){
        $("#dataUser-data").hide()
        toastError("Connection failed !!!")
      }
    })
  }

  function toastSuccess(message) {
    let   element ='<div class="inline-flex flex-shrink-0 justify-center items-center w-8 h-8 text-green-500 bg-green-100 rounded-lg">'
    element +='<svg aria-hidden="true" class="w-5 h-5" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg"><path fill-rule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clip-rule="evenodd"></path></svg>'
    element +='<span class="sr-only text-gray-600">Check icon</span></div>'
    element +='<div class="ml-3 text-sm font-normal">'
    element += message + ' </div>'
    $("#toast-success").html(element)
    $("#toast-success").addClass("bg-green-200")
    $("#toast-success").removeClass("bg-red-200")
    $("#toast-success").show(100)
    setTimeout(function () {
      $("#toast-success").hide()
    },3000)
  }

  function toastError(message) {
    let   element ='<div class="inline-flex flex-shrink-0 justify-center items-center w-8 h-8 text-red-500 bg-red-100 rounded-lg">'
    element +='<svg aria-hidden="true" class="w-5 h-5" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg"><path fill-rule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clip-rule="evenodd"></path></svg>'
    element +='<span class="sr-only text-gray-600">Check icon</span></div>'
    element +='<div class="ml-3 text-sm font-normal">'
    element += message + ' </div>'
    $("#toast-success").html(element)
    $("#toast-success").addClass("bg-red-200")
    $("#toast-success").removeClass("bg-green-200")
    $("#toast-success").show(100)
    setTimeout(function () {
      $("#toast-success").hide()
    },3000)
  }

</script>
</body>
</html>
