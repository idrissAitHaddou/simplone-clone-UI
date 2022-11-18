<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>Title</title>
  <link rel="preconnect" href="https://fonts.googleapis.com" />
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
  <link
          href="https://fonts.googleapis.com/css2?family=Roboto:wght@500&display=swap"
          rel="stylesheet"
  />
  <script src="https://cdn.tailwindcss.com"></script>
  <script>
    tailwind.config = {
      theme: {
        extend: {}
      }
    }
  </script>
  <style type="text/tailwindcss">
    @layer utilities {
      .content-auto {
        content-visibility: auto;
      }
    }
  </style>
  <script src="https://cdn.tailwindcss.com?plugins=forms,typography,aspect-ratio,line-clamp"></script>
  <link rel="stylesheet" href="https://unpkg.com/flowbite@1.5.3/dist/flowbite.min.css" />
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
</head>
<body class="bg-[#14BDEE]">
<div id="toast-success" class="absolute z-[999999] right-2 top-6 flex items-center p-4 mb-4 w-full max-w-xs text-gray-500 rounded-lg shadow" role="alert"></div>
<div id="loadingValidateLogin" class="bg-white absolute z-[9999] right-10 top-8 flex items-center px-4 py-2 text-gray-500 rounded-lg shadow" role="alert">
  <button
          type="submit"
          class="text-[#14BDEE] font-semibold"
  >
    <svg role="status" class="inline mb-0.5 mr-1 w-4 h-4 text-[#14BDEE] animate-spin" viewBox="0 0 100 101" fill="none" xmlns="http://www.w3.org/2000/svg">
      <path d="M100 50.5908C100 78.2051 77.6142 100.591 50 100.591C22.3858 100.591 0 78.2051 0 50.5908C0 22.9766 22.3858 0.59082 50 0.59082C77.6142 0.59082 100 22.9766 100 50.5908ZM9.08144 50.5908C9.08144 73.1895 27.4013 91.5094 50 91.5094C72.5987 91.5094 90.9186 73.1895 90.9186 50.5908C90.9186 27.9921 72.5987 9.67226 50 9.67226C27.4013 9.67226 9.08144 27.9921 9.08144 50.5908Z" fill="#E5E7EB"/>
      <path d="M93.9676 39.0409C96.393 38.4038 97.8624 35.9116 97.0079 33.5539C95.2932 28.8227 92.871 24.3692 89.8167 20.348C85.8452 15.1192 80.8826 10.7238 75.2124 7.41289C69.5422 4.10194 63.2754 1.94025 56.7698 1.05124C51.7666 0.367541 46.6976 0.446843 41.7345 1.27873C39.2613 1.69328 37.813 4.19778 38.4501 6.62326C39.0873 9.04874 41.5694 10.4717 44.0505 10.1071C47.8511 9.54855 51.7191 9.52689 55.5402 10.0491C60.8642 10.7766 65.9928 12.5457 70.6331 15.2552C75.2735 17.9648 79.3347 21.5619 82.5849 25.841C84.9175 28.9121 86.7997 32.2913 88.1811 35.8758C89.083 38.2158 91.5421 39.6781 93.9676 39.0409Z" fill="currentColor"/>
    </svg>
    Validating...
  </button>
</div>
<div class="w-1/2 mx-auto mt-28 border p-6 bg-white rounded-lg">
  <form action="javascript:validateCodeGenerate()">
    <label for="code-generate" class="block mb-2 text-sm font-medium text-gray-900">Enter Code</label>
    <div class="relative">
      <div class="flex absolute inset-y-0 left-0 items-center pl-3 pointer-events-none">
           <svg class="w-5 h-5 text-gray-500" fill="currentColor" viewBox="0 0 1024 1024" xmlns="http://www.w3.org/2000/svg"><path d="M508 280h-63.3c-3.3 0-6 2.7-6 6v340.2H433L197.4 282.6c-1.1-1.6-3-2.6-4.9-2.6H126c-3.3 0-6 2.7-6 6v464c0 3.3 2.7 6 6 6h62.7c3.3 0 6-2.7 6-6V405.1h5.7l238.2 348.3c1.1 1.6 3 2.6 5 2.6H508c3.3 0 6-2.7 6-6V286c0-3.3-2.7-6-6-6zm378 413H582c-4.4 0-8 3.6-8 8v48c0 4.4 3.6 8 8 8h304c4.4 0 8-3.6 8-8v-48c0-4.4-3.6-8-8-8zm-152.2-63c52.9 0 95.2-17.2 126.2-51.7 29.4-32.9 44-75.8 44-128.8 0-53.1-14.6-96.5-44-129.3-30.9-34.8-73.2-52.2-126.2-52.2-53.7 0-95.9 17.5-126.3 52.8-29.2 33.1-43.4 75.9-43.4 128.7 0 52.4 14.3 95.2 43.5 128.3 30.6 34.7 73 52.2 126.2 52.2zm-71.5-263.7c16.9-20.6 40.3-30.9 71.4-30.9 31.5 0 54.8 9.6 71 29.1 16.4 20.3 24.9 48.6 24.9 84.9 0 36.3-8.4 64.1-24.8 83.9-16.5 19.4-40 29.2-71.1 29.2-31.2 0-55-10.3-71.4-30.4-16.3-20.1-24.5-47.3-24.5-82.6.1-35.8 8.2-63 24.5-83.2z"/></svg>
      </div>
      <input type="text" id="code-generate" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full pl-10 p-2.5" placeholder="xxxxxx">
    </div>
    <div class="flex justify-end item-center">
      <button class="bg-[#14BDEE] text-white py-2 px-6 mt-4 rounded-lg">Validate</button>
    </div>
  </form>
</div>
<script>
  $("#toast-success").hide()
  $("#loadingValidateLogin").hide()
  function validateCodeGenerate()  {
    if($("#code-generate").val() != "") {
      $("#loadingValidateLogin").show()
      const formData = new FormData();
      formData.append("code", $("#code-generate").val())
      $.ajax({
        url : "/email/validate-code",
        type: "post",
        data: formData,
        processData: false,
        contentType: false,
        success : function (response){
          $("#loadingValidateLogin").hide()
          response.status == "success" ? window.location = "http://localhost:8085/email/new-password" : toastError("Code is invalid !!! ", "toast-success")
        },
        error : function (error){
          $("#loadingValidateLogin").hide()
          toastError("Connection failed !!!", "toast-success")
        }
      })
    }else {
      $("#loadingValidateLogin").hide()
      toastError("Code is required.", "toast-success")
    }
  }
  // view errors like toast
  function toastError(message, id) {
    let   element ='<div class="inline-flex flex-shrink-0 justify-center items-center w-8 h-8 text-red-500 bg-red-100 rounded-lg">'
    element +='<svg aria-hidden="true" class="w-5 h-5" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg"><path fill-rule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clip-rule="evenodd"></path></svg>'
    element +='<span class="sr-only text-gray-600">Check icon</span></div>'
    element +='<div class="ml-3 text-sm font-normal">'
    element += message + ' </div>'
    $("#"+id+"").html(element)
    $("#"+id+"").addClass("bg-red-200")
    $("#"+id+"").removeClass("bg-green-200")
    $("#"+id+"").show(100)
    setTimeout(function () {
      $("#"+id+"").hide()
    },3000)
  }
</script>
</body>
</html>
