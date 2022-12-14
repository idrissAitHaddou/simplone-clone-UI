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
    <a href="/learner/breifs" class="mb-2 inline-flex justify-between items-center py-2 px-3 text-sm font-medium text-center text-white bg-[#14BDEE] rounded-lg focus:ring-4 focus:outline-none focus:ring-blue-300">
<%--      <svg width="512" class="ml-2 -mr-1 w-4 h-4" height="512" fill="currentColor" viewBox="0 0 512 512" data-name="Layer 1" xmlns="http://www.w3.org/2000/svg"><path d="M34 256 210 80l21.21 21.2L91.4 241H478v30H91.4l139.85 139.84L210 432Z"/></svg>--%>
      <svg width="24" height="24" viewBox="0 0 24 24" fill="currentColor" xmlns="http://www.w3.org/2000/svg"><path d="M21 11H6.414l5.293-5.293-1.414-1.414L2.586 12l7.707 7.707 1.414-1.414L6.414 13H21z"/></svg>
    </a>
    <div class="flex">
      <%--     start card breif description   --%>
      <div class="w-full bg-white rounded-lg border border-gray-200 shadow-md">
        <a href="#">
          <img id="image" class="rounded-t-lg w-full h-56 border" src="" alt="" />
        </a>
        <div class="p-5">
          <a href="#">
            <h5 id="title" class="mb-2 text-1xl font-bold tracking-tight text-gray-900"></h5>
          </a>
          <p id="description" class="mb-3 font-normal text-gray-700"></p>
        </div>
      </div>
      <%--    end card breif description   --%>
    </div>
  </div>
</div>
<script>
  // hide elemment when loading page
  $("#toast-success").hide()
  // get details of breif
  getBreifDetails()
  function getBreifDetails() {
    $.ajax({
      url  : "/learner/get-breifs-deatils",
      type : "get",
      success : function (response){
        const breifs = JSON.parse(response)
        for(const breif of breifs) {
          $("#title").html(breif[1])
          $("#description").html(breif[2])
          $("#image").attr("src","${pageContext.request.contextPath}/assets/images/"+ breif[4])
        }
      },
      error : function (error){
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
