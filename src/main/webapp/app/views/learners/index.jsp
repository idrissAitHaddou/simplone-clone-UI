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
<jsp:include page="partails/edit.jsp"/>
<div id="toast-success" class="absolute z-[999999] right-2 -top-2 flex items-center p-4 mb-4 w-full max-w-xs text-gray-500 rounded-lg shadow" role="alert"></div>
<div class="p-6">
    <nav class="flex justify-between mb-8" aria-label="Breadcrumb">
      <select id="dsbfksgs" name="type_extra" class="font-bold text-gray-600 block max-w-lg w-64 shadow-sm focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm border-gray-300 rounded-md">
        <option value="" disabled selected class="">Select User</option>
        <option value="former">Former</option>
        <option value="learner">Learner</option>
      </select>
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
            Promotion
          </th>
          <th scope="col" class="py-3 px-6 md:block hidden">
            Actions
          </th>
        </tr>
        </thead>
        <tbody>
        <tr class='bg-white border-b hover:bg-gray-50'>
          <th scope='row' class='py-4 px-6 font-medium text-gray-900 whitespace-nowrap'>test </th>
          <td class='py-4 px-6'>test</td>
          <td class='py-4 px-6'>test</td>
          <td class='py-4 px-6'>test</td>
          <td class='py-4 px-6 text-right flex md:flex hidden'>
            <button type='button' onclick='showModalDeleteExtraxs(1)' >
              <svg width='18px' height='18px' viewBox='0 0 18 18' xmlns='http://www.w3.org/2000/svg'> <path fill='#FF0000' d='M13 18H5a2 2 0 0 1-2-2V7a1 1 0 0 1 1-1h10a1 1 0 0 1 1 1v9a2 2 0 0 1-2 2zm3-15a1 1 0 0 1-1 1H3a1 1 0 0 1 0-2h3V1a1 1 0 0 1 1-1h4a1 1 0 0 1 1 1v1h3a1 1 0 0 1 1 1z'></path> </svg>
            </button>
            <button type='button' onclick='showModalEditExtrax("+extra.id_extra+")' class='ml-4'> <svg fill='#1AE310' width='24px' height='24px' viewBox='0 0 24 24' xmlns='http://www.w3.org/2000/svg'><path d='m18.988 2.012 3 3L19.701 7.3l-3-3zM8 16h3l7.287-7.287-3-3L8 13z'></path><path d='M19 19H8.158c-.026 0-.053.01-.079.01-.033 0-.066-.009-.1-.01H5V5h6.847l2-2H5c-1.103 0-2 .896-2 2v14c0 1.104.897 2 2 2h14a2 2 0 0 0 2-2v-8.668l-2 2V19z'/></svg>
            </button>
          </td>
        </tr>
        </tbody>
      </table>
      <div id="dataExrtax-data"></div>
    </div>
</div>
<%-- start modael for delete one room --%>
<button data-modal-toggle="delete-extrax-modal" hidden id="btnToogleDeleteExtraxModal">show modal</button>
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
        <button id="btnDeleteExtrax" type="button" class="text-white bg-red-600 hover:bg-red-800 focus:ring-4 focus:outline-none focus:ring-red-300 font-medium rounded-lg text-sm inline-flex items-center px-5 py-2.5 text-center mr-2">
          Yes, I'm sure
        </button>
        <button data-modal-toggle="delete-extrax-modal" type="button" class="text-gray-500 bg-white hover:bg-gray-100 focus:ring-4 focus:outline-none focus:ring-gray-200 rounded-lg border border-gray-200 text-sm font-medium px-5 py-2.5 hover:text-gray-900 focus:z-10">No, cancel</button>
      </div>
    </div>
  </div>
</div>
<script type="text/javascript">
  // hide elemment when loading page
  $("#toast-success").hide()
  $("#loadingAdd").hide()
  $("#loadingEdit").hide()
  $("#dataExrtax-data").hide()
  // show modal for validate delete room rates
  function showModalDeleteExtraxs(idExtrax) {
    $("#btnDeleteExtrax").attr("onclick", "deleteExtra(" + idExtrax + ")")
    $("#btnToogleDeleteExtraxModal").click()
  }
  // validate add extrax
  function validateExtrax(type_extra, rate) {
    if(rate <=0 || type_extra == '') return 0
    return 1
  }
  // edit extrax
  function editExtrax() {
    const formData = new FormData();
    let typeExtra = $("#edit-type-extra").val()
    let rate = $("#edit-rate").val()
    let idExtra = $("#id-extra-edit").val()
    formData.append("type_extra", typeExtra)
    formData.append("rate", rate)
    formData.append("id_extra", idExtra)
    let validateValue = validateExtrax(typeExtra, rate);
    if(validateValue == 1) {
      $("#loadingEdit").show()
      $.ajax({
        url : "/admin/extra/update",
        type: "post",
        data: formData,
        processData: false,
        contentType: false,
        success : function (response){
          fetchDataExtra()
          $("#loadingEdit").hide()
          $("#btnEditToogleExtrax").click()
          const res = JSON.parse(response);
          res.message == "success" ? toastSuccess("Extrax updated successfully.") : toastError("Extrax not updated !!!")
        },
        error : function (error){
          toastError("Connection failed !!!")
        }
      })
    } else {
      $("#loadingEdit").hide()
      toastError("All informations required.")
    }
  }
  // add extrax
  function addExtrax() {
    const formData = new FormData();
    let type_extra = $("#type_extra").val()
    let rate = $("#rate").val()
    formData.append("type_extra", type_extra)
    formData.append("rate", rate)
    let validateValue = validateExtrax(type_extra, rate);
    if(validateValue == 1) {
      $("#loadingAdd").show()
      $.ajax({
        url : "/admin/extra/store",
        type: "post",
        data: formData,
        processData: false,
        contentType: false,
        success : function (response){
          fetchDataExtra()
          $("#loadingAdd").hide()
          $("#btn-colse-model").click()
          const res = JSON.parse(response);
          res.message == "success" ? toastSuccess("Extrax added successfully.") : toastError("Extrax not added !!!")
        },
        error : function (error){
          toastError("Connection failed !!!")
        }
      })
    } else {
      $("#loadingAdd").hide()
      toastError("All informations required.")
    }
  }
  // get all extraxs
  // fetchDataExtra()
  function fetchDataExtra() {
    let element = '<div class="flex justify-center overflow-hidden"><div class="mx-auto mt-10 w-8 h-8 border-4 border-dashed rounded-full animate-spin dark:border-violet-400"></div></div>'
    $("#dataExrtax-data").html(element)
    $.ajax({
      url : "/admin/extra/get",
      type : "GET",
      success : function (response){
        const extras = JSON.parse(response)
        let stringHtml=""
        for (const extra of extras) {
          stringHtml += "<tr class='bg-white border-b hover:bg-gray-50'><th scope='row' class='py-4 px-6 font-medium text-gray-900 whitespace-nowrap'>"+extra.type_extra+" </th> <td class='py-4 px-6'>$"+extra.rate+" </td>  <td class='py-4 px-6 text-right flex md:flex hidden'> <button type='button' onclick='showModalDeleteExtraxs("+extra.id_extra+")' > <svg width='18px' height='18px' viewBox='0 0 18 18' xmlns='http://www.w3.org/2000/svg'> <path fill='#FF0000' d='M13 18H5a2 2 0 0 1-2-2V7a1 1 0 0 1 1-1h10a1 1 0 0 1 1 1v9a2 2 0 0 1-2 2zm3-15a1 1 0 0 1-1 1H3a1 1 0 0 1 0-2h3V1a1 1 0 0 1 1-1h4a1 1 0 0 1 1 1v1h3a1 1 0 0 1 1 1z'></path> </svg> </button> <button type='button' onclick='showModalEditExtrax("+extra.id_extra+")' class='ml-4'> <svg fill='#0000FF' width='24px' height='24px' viewBox='0 0 24 24' xmlns='http://www.w3.org/2000/svg'><path d='m18.988 2.012 3 3L19.701 7.3l-3-3zM8 16h3l7.287-7.287-3-3L8 13z'></path><path d='M19 19H8.158c-.026 0-.053.01-.079.01-.033 0-.066-.009-.1-.01H5V5h6.847l2-2H5c-1.103 0-2 .896-2 2v14c0 1.104.897 2 2 2h14a2 2 0 0 0 2-2v-8.668l-2 2V19z'/></svg> </button> </td> </tr>"
        }
        $("#dataExrtax-data").hide()
        $("tbody").html(stringHtml)
      },
      error : function (error){
        console.error(error)
      }
    })
  }

  // show modal for edit room
  function showModalEditExtrax(idExtrax) {
    fetchOneExtra(idExtrax)
    $("#btnEditToogleExtrax").click()
  }

  function deleteExtra(idExtra){
    $.ajax({
      url : "/admin/extra/delete",
      type: "post",
      data: {
        id : idExtra,
      },
      success : function (response){
        const res = JSON.parse(response);
        if (res.message === "success"){
          fetchDataExtra()
          $("#btnToogleDeleteExtraxModal").click()
          toastSuccess("Extrax deleted successfully")
        }else {
          toastError("Extrax not deleted !!!")
        }
      },
      error : function (error){
        toastError("Connection failed !!!")
      }
    })
  }

  function fetchOneExtra(idExtra){

    $.ajax({
      url : "/admin/extra/one",
      type : "POST",
      data: {
        id : idExtra,
      },
      success :  function (response) {
        const room = JSON.parse(response)[0];
        $("#edit-type-extra").val(room.type_extra)
        $("#edit-rate").val(room.rate)
        $("#id-extra-edit").val(room.id_extra)
      },
      error : function (error){
        console.error(error)
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
