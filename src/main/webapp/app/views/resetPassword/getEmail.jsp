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
        Sending...
      </button>
    </div>
    <div class="w-1/2 mx-auto mt-28 border p-6 bg-white rounded-lg">
      <form action="javascript:getEmail()">
        <label for="email" class="block mb-2 text-sm font-medium text-gray-900">Your Email</label>
        <div class="relative">
          <div class="flex absolute inset-y-0 left-0 items-center pl-3 pointer-events-none">
            <svg aria-hidden="true" class="w-5 h-5 text-gray-500" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg"><path d="M2.003 5.884L10 9.882l7.997-3.998A2 2 0 0016 4H4a2 2 0 00-1.997 1.884z"></path><path d="M18 8.118l-8 4-8-4V14a2 2 0 002 2h12a2 2 0 002-2V8.118z"></path></svg>
          </div>
          <input type="text" id="email" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full pl-10 p-2.5" placeholder="Enter email">
        </div>
        <div class="flex justify-end item-center">
          <button class="bg-[#14BDEE] text-white py-2 px-6 mt-4 rounded-lg">Send</button>
        </div>
      </form>
    </div>
<script>
  $("#toast-success").hide()
  $("#loadingValidateLogin").hide()
  function getEmail()  {
    $("#loadingValidateLogin").show()
    if($("#email").val() != "") {
      const formData = new FormData();
      formData.append("email", $("#email").val())
      $.ajax({
        url : "/email/generate-code",
        type: "post",
        data: formData,
        processData: false,
        contentType: false,
        success : function (response){
          $("#loadingValidateLogin").hide()
          response.status == "success" ? window.location = "http://localhost:8085/email/enter-password" : toastError("Not generate code, Try again ", "toast-success")
        },
        error : function (error){
          $("#loadingValidateLogin").hide()
          toastError("Connection failed !!!", "toast-success")
        }
      })
    }else {
      $("#loadingValidateLogin").hide()
      toastError("Email is required.", "toast-success")
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
