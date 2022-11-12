<%--<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>--%>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
<script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<jsp:include page="partails/add.jsp"/>
<div id="toast-success" class="absolute z-[999999] right-2 -top-2 flex items-center p-4 mb-4 w-full max-w-xs text-gray-500 rounded-lg shadow" role="alert"></div>
<div class="p-6">
    <nav class="flex justify-between mb-8" aria-label="Breadcrumb">
      <div class="flex">
        <input id="searchName" type="text" placeholder="Search by name" class="text-gray-800 block max-w-lg w-64 shadow-sm focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm border-gray-300 rounded-md">
        <button class="">
          <svg onclick="seacrhLearners()" class="ml-2" width="20" height="20" viewBox="0 0 48 48" xmlns="http://www.w3.org/2000/svg"><circle cx="19" cy="19" r="17" fill="#aedff5"/><path d="M46 48a2 2 0 0 1-1.37-.54L30 33.75a2 2 0 1 1 2.74-2.92l14.6 13.71A2 2 0 0 1 46 48Z" fill="#38b1e7"/><path d="M19 38a19 19 0 1 1 19-19 19 19 0 0 1-19 19Zm0-34a15 15 0 1 0 15 15A15 15 0 0 0 19 4Z" fill="#38b1e7"/></svg>
        </button>
      </div>
      <button type="button" data-modal-toggle="add-extra-modal" class="flex py-1 item-center px-3 bg-[#14BDEE] rounded-lg text-white md:flex hidden">
        <span class="mt-1 text-white">Add</span>
        <svg class="ml-3 mt-1" fill="#fff" width="24" height="24" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path fill="none" d="M0 0h24v24H0z"></path><path d="M11 11V5h2v6h6v2h-6v6h-2v-6H5v-2z"/></svg>
      </button>
    </nav>
    <div class="overflow-x-auto relative sm:rounded-lg">
      <table class="w-full text-sm text-left">
        <thead class="bg-white text-xs text-gray-700 uppercase">
        <tr>
          <th scope="col" class="py-3 px-6">
            Firstname
          </th>
          <th scope="col" class="py-3 px-6">
            Lastname
          </th>
          <th scope="col" class="py-3 px-6">
            Email
          </th>
          <th scope="col" class="py-3 px-6">
            Role
          </th>
          <th scope="col" class="py-3 px-6 md:block hidden">
            Actions
          </th>
        </tr>
        </thead>
        <tbody>
        </tbody>
      </table>
      <div id="dataUser-data"></div>
    </div>
</div>
<%-- start modael for delete one room --%>
<button data-modal-toggle="delete-extrax-modal" hidden id="btnToogleDeleteLearnerModal">show modal</button>
<div id="delete-extrax-modal" tabindex="-1" class="hidden overflow-y-auto overflow-x-hidden fixed top-0 right-0 left-0 z-50 md:inset-0 h-modal md:h-full">
  <div class="relative p-4 w-full max-w-md h-full md:h-auto">
    <div class="relative bg-white rounded-lg shadow">
      <button data-modal-toggle="delete-extrax-modal" type="button" class="absolute top-3 right-2.5 text-gray-400 bg-transparent hover:bg-gray-200 hover:text-gray-900 rounded-lg text-sm p-1.5 ml-auto inline-flex items-center">
        <svg aria-hidden="true" class="w-5 h-5" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg"><path fill-rule="evenodd" d="M4.293 4.293a1 1 0 011.414 0L10 8.586l4.293-4.293a1 1 0 111.414 1.414L11.414 10l4.293 4.293a1 1 0 01-1.414 1.414L10 11.414l-4.293 4.293a1 1 0 01-1.414-1.414L8.586 10 4.293 5.707a1 1 0 010-1.414z" clip-rule="evenodd"></path></svg>
        <span class="sr-only">Close modal</span>
      </button>
      <div class="p-6 text-center">
        <svg aria-hidden="true" class="mx-auto mb-4 w-14 h-14 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4m0 4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z"></path></svg>
        <h3 class="mb-5 text-lg font-normal text-gray-500">Are you sure you want to delete this room?</h3>
        <button id="btnDeleteLearner" type="button" class="text-white bg-red-600 hover:bg-red-800 focus:ring-4 focus:outline-none focus:ring-red-300 font-medium rounded-lg text-sm inline-flex items-center px-5 py-2.5 text-center mr-2">
          <svg id="loadingDelete" role="status" class="inline mt-1 mr-3 w-4 h-4 text-white animate-spin" viewBox="0 0 100 101" fill="none" xmlns="http://www.w3.org/2000/svg">
            <path d="M100 50.5908C100 78.2051 77.6142 100.591 50 100.591C22.3858 100.591 0 78.2051 0 50.5908C0 22.9766 22.3858 0.59082 50 0.59082C77.6142 0.59082 100 22.9766 100 50.5908ZM9.08144 50.5908C9.08144 73.1895 27.4013 91.5094 50 91.5094C72.5987 91.5094 90.9186 73.1895 90.9186 50.5908C90.9186 27.9921 72.5987 9.67226 50 9.67226C27.4013 9.67226 9.08144 27.9921 9.08144 50.5908Z" fill="#E5E7EB"/>
            <path d="M93.9676 39.0409C96.393 38.4038 97.8624 35.9116 97.0079 33.5539C95.2932 28.8227 92.871 24.3692 89.8167 20.348C85.8452 15.1192 80.8826 10.7238 75.2124 7.41289C69.5422 4.10194 63.2754 1.94025 56.7698 1.05124C51.7666 0.367541 46.6976 0.446843 41.7345 1.27873C39.2613 1.69328 37.813 4.19778 38.4501 6.62326C39.0873 9.04874 41.5694 10.4717 44.0505 10.1071C47.8511 9.54855 51.7191 9.52689 55.5402 10.0491C60.8642 10.7766 65.9928 12.5457 70.6331 15.2552C75.2735 17.9648 79.3347 21.5619 82.5849 25.841C84.9175 28.9121 86.7997 32.2913 88.1811 35.8758C89.083 38.2158 91.5421 39.6781 93.9676 39.0409Z" fill="currentColor"/>
          </svg>
          Yes, I'm sure
        </button>
        <button data-modal-toggle="delete-extrax-modal" type="button" class="text-gray-500 bg-white hover:bg-gray-100 focus:ring-4 focus:outline-none focus:ring-gray-200 rounded-lg border border-gray-200 text-sm font-medium px-5 py-2.5 hover:text-gray-900 focus:z-10">No, cancel</button>
      </div>
    </div>
  </div>
</div>
<script type="text/javascript">
  // get users by type
  function getUsersByType() {
    const type = $("#get-users-by-type").val()
    type == "all" ? getAllusers() : type == "formers" ? getAllFormers() : type == "learners" ? getAllLearners() : getAllusers()
  }
  // hide elemment when loading page
  $("#toast-success").hide()
  $("#loadingAdd").hide()
  $("#loadingDelete").hide()
  $("#loadingEdit").hide()
  $("#dataUser-data").hide()
  // validate info for add or edit user
  function validateUser(firstname, lastname, email, password, userType) {
    if(firstname == "" || lastname == "" || email == "" || password == "" || userType == "" || userType == null) return 0
    return 1
  }
  function validateEditUser(firstname, lastname, email) {
    if(firstname == "" || lastname == "" || email == "") return 0
    return 1
  }

  // get all learners for add to my promo
  function addLearnerToMyPromo() {
    console.log($("#learnersSelect").val())
    if($("#learnersSelect").val() != 0) {
      const formData = new FormData()
      formData.append("idLearner", $("#learnersSelect").val())
      $("#loadingAdd").show()
      $.ajax({
        url : "/former/add-learner-to-promo",
        type : "post",
        data: formData,
        processData: false,
        contentType: false,
        success : function (response){
          $("#loadingAdd").hide()
          getAllLearners()
          $("#btn-colse-model").click()
          if (response.status === "success"){
            toastSuccess("Learner added successfully")
          }else {
            toastError("Learner not added !!!")
          }
        },
        error : function (error){
          toastError("Connection failed !!!")
        }
      })
    } else {
      toastError("No Learner exist for add !!!")
      getAllLearners()
    }
  }

  // add user ( former or learner )
  function addUser() {
    const formData = new FormData();
    let firstname = $("#firstname").val()
    let lastname = $("#lastname").val()
    let email = $("#email").val()
    let password = $("#password").val()
    let userType = $("#userType").val()
    formData.append("firstname", firstname)
    formData.append("lastname", lastname)
    formData.append("email", email)
    formData.append("password", password)
    formData.append("userType", userType)
    let validateValue = validateUser(firstname, lastname, email, password, userType);
    if(validateValue == 1) {
      $("#loadingAdd").show()
      $.ajax({
        url : "/admin/create-user",
        type: "post",
        data: formData,
        processData: false,
        contentType: false,
        success : function (response){
          getUsersByType()
          $("#loadingAdd").hide()
          $("#btnAdd-colse-model").click()
          response.status == "success" ? toastSuccess("User added successfully.") : toastError("User not added !!!")
        },
        error : function (error){
          // getAllusers()
          $("#loadingAdd").hide()
          toastError("Connection failed !!!")
        }
      })
    } else {
      $("#loadingAdd").hide()
      toastError("All informations required.")
    }
  }

  // get all learners for add to my promo
  getAllLearnerWithoutPromo()
  function getAllLearnerWithoutPromo() {
    $.ajax({
      url : "/former/get-learners-no-promo",
      type : "get",
      success : function (response){
        const learners = JSON.parse(response)
        let stringHtml=""
        stringHtml += "<option value='0'> select learner </option>"
        for (const learner of learners) {
          stringHtml += "<option value='" + learner[0] + "'> " + learner[2] + " " + learner[1] + " </option>"
        }
        $("#dataUser-data").hide()
        $("#learnersSelect").html(stringHtml)
      },
      error : function (error){
        $("#dataUser-data").hide()
        toastError("Connection failed !!!")
      }
    })
  }
  // get all learners
  getAllLearners()
  function getAllLearners() {
    let element = '<div class="flex justify-center overflow-hidden"><div class="mx-auto mt-10 w-8 h-8 border-4 border-dashed rounded-full animate-spin dark:border-violet-400"></div></div>'
    $("#dataUser-data").html(element)
    $("#dataUser-data").show()
    $.ajax({
      url : "/former/get-learners",
      type : "get",
      success : function (response){
        const learners = JSON.parse(response)
        let stringHtml=""
        for (const learner of learners) {
          stringHtml += "<tr class='bg-white border-b hover:bg-gray-50'>"
          stringHtml += "<td class='py-4 px-6'>"+learner[2]+" </td>"
          stringHtml += "<td class='py-4 px-6'>"+learner[1]+" </td>"
          stringHtml += "<td class='py-4 px-6'>"+learner[3]+" </td>"
          stringHtml += "<td class='py-4 px-6'> Learner </td>"
          stringHtml += "<td><div class='flex justify-center'>"
          stringHtml += "<button type='button' onclick='showModalDeleteLearner("+learner[0]+")' > <svg width='18px' height='18px' viewBox='0 0 18 18' xmlns='http://www.w3.org/2000/svg'> <path fill='#FF0000' d='M13 18H5a2 2 0 0 1-2-2V7a1 1 0 0 1 1-1h10a1 1 0 0 1 1 1v9a2 2 0 0 1-2 2zm3-15a1 1 0 0 1-1 1H3a1 1 0 0 1 0-2h3V1a1 1 0 0 1 1-1h4a1 1 0 0 1 1 1v1h3a1 1 0 0 1 1 1z'></path> </svg> </button>"
          stringHtml += "</div>"
          stringHtml += " </td></tr>"
        }
        $("#dataUser-data").hide()
        $("tbody").html(stringHtml)
      },
      error : function (error){
        $("#dataUser-data").hide()
        toastError("Connection failed !!!")
      }
    })
  }

  // searche learners
  function seacrhLearners() {
    let element = '<div class="flex justify-center overflow-hidden"><div class="mx-auto mt-10 w-8 h-8 border-4 border-dashed rounded-full animate-spin dark:border-violet-400"></div></div>'
    $("#dataUser-data").html(element)
    $("#dataUser-data").show()
    if($("#searchName").val() != "") {
      console.log($("#searchName").val())
      const formData = new FormData()
      formData.append("name", $("#searchName").val())
      $.ajax({
        url : "/former/search-learners",
        type : "post",
        data: formData,
        processData: false,
        contentType: false,
        success : function (response){
          const learners = JSON.parse(response)
          let stringHtml=""
          for (const learner of learners) {
            stringHtml += "<tr class='bg-white border-b hover:bg-gray-50'>"
            stringHtml += "<td class='py-4 px-6'>"+learner[2]+" </td>"
            stringHtml += "<td class='py-4 px-6'>"+learner[1]+" </td>"
            stringHtml += "<td class='py-4 px-6'>"+learner[3]+" </td>"
            stringHtml += "<td class='py-4 px-6'> Learner </td>"
            stringHtml += "<td><div class='flex justify-center'>"
            stringHtml += "<button type='button' onclick='showModalDeleteLearner("+learner[0]+")' > <svg width='18px' height='18px' viewBox='0 0 18 18' xmlns='http://www.w3.org/2000/svg'> <path fill='#FF0000' d='M13 18H5a2 2 0 0 1-2-2V7a1 1 0 0 1 1-1h10a1 1 0 0 1 1 1v9a2 2 0 0 1-2 2zm3-15a1 1 0 0 1-1 1H3a1 1 0 0 1 0-2h3V1a1 1 0 0 1 1-1h4a1 1 0 0 1 1 1v1h3a1 1 0 0 1 1 1z'></path> </svg> </button>"
            stringHtml += "</div>"
            stringHtml += " </td></tr>"
          }
          $("#dataUser-data").hide()
          $("tbody").html(stringHtml)
        },
        error : function (error){
          $("#dataUser-data").hide()
          toastError("Connection failed !!!")
        }
      })
    } else {
      getAllLearners()
    }
  }

  // show modal for edit room
  function showModalEditUser(idUser, role) {
    fetchOneUser(idUser, role)
    $("#btnEditToogleUser").click()
  }

  // show modal delete learner in my promotion
  function showModalDeleteLearner(idUser) {
    $("#btnDeleteLearner").attr("onclick", "deleteLearner(" + idUser + ")")
    $("#btnToogleDeleteLearnerModal").click()
  }

  function deleteLearner(idLearner){
    const formData = new FormData()
    formData.append("id", idLearner)
    $("#loadingDelete").show()
    $.ajax({
      url : "/fromer/delete-learner",
      type: "post",
      data: formData,
      contentType: 'application/json; charset=utf-8',
      processData: false,
      contentType: false,
      success : function (response){
        $("#loadingDelete").hide()
        getAllLearners()
        getAllLearnerWithoutPromo()
        $("#btnToogleDeleteLearnerModal").click()
        if (response.status === "success"){
          toastSuccess("User deleted successfully")
        }else {
          toastError("User not deleted !!!")
        }
      },
      error : function (error){
        $("#loadingDelete").hide()
        toastError("Connection failed !!!")
      }
    })
  }

  function fetchOneUser(idUser, role){
    const formData = new FormData()
    formData.append("id", idUser)
    formData.append("role", role)
    $.ajax({
      url : "/admin/get-user",
      type : "POST",
      data:formData,
      contentType: 'application/json; charset=utf-8',
      processData: false,
      contentType: false,
      success :  function (response) {
        const user = JSON.parse(response)[0]
        $("#editFirstname").val(user.prenom)
        $("#editLastname").val(user.nom)
        $("#editEmail").val(user.email)
        $("#editPassword").val("")
        $("#btnEditUsre").attr("onclick", "editUser(" + idUser + ", " + role + ")")
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
