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
    Changing...
  </button>
</div>
<div class="w-1/2 mx-auto mt-28 border p-6 bg-white rounded-lg">
  <form action="javascript:changePasswordForget()">
    <label for="new-password" class="block mb-2 text-sm font-medium text-gray-900">New password</label>
    <div class="relative">
      <div class="flex absolute inset-y-0 left-0 items-center pl-3 pointer-events-none">
        <svg class="w-5 h-5 text-gray-500" fill="currentColor" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512" style="enable-background:new 0 0 512 512" xml:space="preserve"><path d="M406.261 247.741v-97.48C406.261 67.407 338.854 0 256 0S105.739 67.407 105.739 150.261v97.48c-19.433 6.892-33.391 25.45-33.391 47.215v166.956c0 27.618 22.469 50.087 50.087 50.087h267.13c27.618 0 50.087-22.469 50.087-50.087V294.957c0-21.766-13.959-40.324-33.391-47.216zm-267.131-97.48c0-64.442 52.428-116.87 116.87-116.87s116.87 52.428 116.87 116.87v94.609h-33.391v-94.609c0-46.03-37.448-83.478-83.478-83.478s-83.478 37.448-83.478 83.478v94.609H139.13v-94.609zm166.957 0v94.609H205.913v-94.609c0-27.618 22.469-50.087 50.087-50.087 27.618 0 50.087 22.469 50.087 50.087zm100.174 311.652c0 9.206-7.49 16.696-16.696 16.696h-267.13c-9.206 0-16.696-7.49-16.696-16.696V294.957c0-9.206 7.49-16.696 16.696-16.696h267.13c9.206 0 16.696 7.49 16.696 16.696v166.956z"/><path d="M256 311.652c-18.412 0-33.391 14.979-33.391 33.391 0 12.333 6.725 23.117 16.696 28.899v54.579c0 9.22 7.475 16.696 16.696 16.696s16.696-7.475 16.696-16.696v-54.579c9.971-5.782 16.696-16.567 16.696-28.899-.002-18.411-14.981-33.391-33.393-33.391z"/></svg>
      </div>
      <input type="text" id="new-password" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full pl-10 p-2.5" placeholder="New password">
    </div>
    <label for="confirme-password" class="block mb-2 text-sm font-medium text-gray-900">Confirme password</label>
    <div class="relative">
      <div class="flex absolute inset-y-0 left-0 items-center pl-3 pointer-events-none">
        <svg class="w-5 h-5 text-gray-500" fill="currentColor" viewBox="0 0 32 32" xmlns="http://www.w3.org/2000/svg"><path d="M14 16.59 11.41 14 10 15.41l4 4 8-8L20.59 10 14 16.59z"/><path d="m16 30-6.176-3.293A10.982 10.982 0 0 1 4 17V4a2.002 2.002 0 0 1 2-2h20a2.002 2.002 0 0 1 2 2v13a10.982 10.982 0 0 1-5.824 9.707ZM6 4v13a8.985 8.985 0 0 0 4.766 7.942L16 27.733l5.234-2.79A8.985 8.985 0 0 0 26 17V4Z"/><path data-name="&lt;Transparent Rectangle&gt;" style="fill:none" d="M0 0h32v32H0z"/></svg>
      </div>
      <input type="text" id="confirme-password" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full pl-10 p-2.5" placeholder="Confirme password">
    </div>
    <div class="flex justify-end item-center">
      <button type="submit" class="bg-[#14BDEE] text-white py-2 px-6 mt-4 rounded-lg">Change</button>
    </div>
  </form>
</div>
<script>
  $("#toast-success").hide()
  $("#loadingValidateLogin").hide()
  function changePasswordForget()  {
    const newPassword = $("#new-password").val()
    const confirmePassword = $("#confirme-password").val()
    if(newPassword != "" && confirmePassword != "") {
        if(newPassword == confirmePassword) {
          $("#loadingValidateLogin").show()
          const formData = new FormData();
          formData.append("password", newPassword)
          $.ajax({
            url : "/email/change-password",
            type: "post",
            data: formData,
            processData: false,
            contentType: false,
            success : function (response){
              $("#loadingValidateLogin").hide()
              if(response.status == "success") {
                if(response.role == "learner") window.location = "http://localhost:8085/learner/login"
                if(response.role == "former") window.location = "http://localhost:8085/former/login"
                if(response.role == "admin") window.location = "http://localhost:8085/admin/login"
              }else {
                toastError("Password not changed, Try again !!! ", "toast-success")
              }
            },
            error : function (error){
              $("#loadingValidateLogin").hide()
              toastError("Connection failed !!!", "toast-success")
            }
          })
        }else {
          $("#loadingValidateLogin").hide()
          toastError("Password not confirmed.", "toast-success")
        }
    }else {
      $("#loadingValidateLogin").hide()
      toastError("All information are required.", "toast-success")
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
