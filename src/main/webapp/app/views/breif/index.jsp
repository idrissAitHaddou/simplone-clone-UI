<%--<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>--%>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
<script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
  <style>
    label {
      display: block;
      width: 20px;
      height: 20px;
      cursor: pointer;
    }

    input[type='checkbox'] {
      position: absolute;
      transform: scale(0);
    }

    input[type='checkbox']:checked ~ .checkbox {
      transform: rotate(45deg);
      width: 14px;
      margin-left: 5px;
      border-color: #24c78e;
      border-width: 5px;
      border-top-color: transparent;
      border-left-color: transparent;
      border-radius: 0;
    }

    .checkbox {
      display: block;
      width: inherit;
      height: inherit;
      border: solid 3px #2a2a2ab7;
      border-radius: 6px;
      transition: all 0.375s;
    }
  </style>
</head>
<body>
<jsp:include page="partails/add.jsp"/>
<jsp:include page="partails/edit.jsp"/>
<div id="toast-success" class="absolute z-[999999] right-2 -top-2 flex items-center p-4 mb-4 w-full max-w-xs text-gray-500 rounded-lg shadow" role="alert"></div>
<div class="p-6">
    <nav class="flex justify-between mb-8" aria-label="Breadcrumb">
      <div class="flex">
        <input id="searchName" type="text" placeholder="Search by name" class="text-gray-800 block max-w-lg w-64 shadow-sm focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm border-gray-300 rounded-md">
        <button class="">
          <svg onclick="searchBreif()" class="ml-2" width="20" height="20" viewBox="0 0 48 48" xmlns="http://www.w3.org/2000/svg"><circle cx="19" cy="19" r="17" fill="#aedff5"/><path d="M46 48a2 2 0 0 1-1.37-.54L30 33.75a2 2 0 1 1 2.74-2.92l14.6 13.71A2 2 0 0 1 46 48Z" fill="#38b1e7"/><path d="M19 38a19 19 0 1 1 19-19 19 19 0 0 1-19 19Zm0-34a15 15 0 1 0 15 15A15 15 0 0 0 19 4Z" fill="#38b1e7"/></svg>
        </button>
      </div>      <button type="button" data-modal-toggle="add-extra-modal" class="flex py-1 item-center px-3 bg-[#14BDEE] rounded-lg text-white md:flex hidden">
        <span class="mt-1 text-white">Add</span>
        <svg class="ml-3 mt-1" fill="#fff" width="24" height="24" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path fill="none" d="M0 0h24v24H0z"></path><path d="M11 11V5h2v6h6v2h-6v6h-2v-6H5v-2z"/></svg>
      </button>
    </nav>
    <div class="overflow-x-auto relative sm:rounded-lg">
      <table class="w-full text-sm text-left">
        <thead class="bg-white text-xs text-gray-700 uppercase">
        <tr>
          <th scope="col" class="py-3 px-6">
            Name
          </th>
          <th scope="col" class="py-3 px-6">
            Launch
          </th>
          <th scope="col" class="py-3 text-center px-6 md:block hidden">
            Actions
          </th>
        </tr>
        </thead>
        <tbody>
        </tbody>
      </table>
      <div id="dataBreif-data"></div>
    </div>
</div>
<%-- start modael for delete breif --%>
<button data-modal-toggle="delete-extrax-modal" hidden id="btnToogleDeleteBreifModal">show modal</button>
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
        <button id="btnDeleteBreif" type="button" class="text-white bg-red-600 hover:bg-red-800 focus:ring-4 focus:outline-none focus:ring-red-300 font-medium rounded-lg text-sm inline-flex items-center px-5 py-2.5 text-center mr-2">
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

<%-- start modael for launch breif --%>
<button data-modal-toggle="launch-breif-modal" hidden id="btnToogleLaunchBreifModal">show modal</button>
<div id="launch-breif-modal" tabindex="-1" class="hidden overflow-y-auto overflow-x-hidden fixed top-0 right-0 left-0 z-50 md:inset-0 h-modal md:h-full">
  <div class="relative p-4 w-full max-w-md h-full md:h-auto">
    <div class="relative bg-white rounded-lg shadow">
      <button data-modal-toggle="launch-breif-modal" type="button" class="absolute top-3 right-2.5 text-gray-400 bg-transparent hover:bg-gray-200 hover:text-gray-900 rounded-lg text-sm p-1.5 ml-auto inline-flex items-center">
        <svg aria-hidden="true" class="w-5 h-5" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg"><path fill-rule="evenodd" d="M4.293 4.293a1 1 0 011.414 0L10 8.586l4.293-4.293a1 1 0 111.414 1.414L11.414 10l4.293 4.293a1 1 0 01-1.414 1.414L10 11.414l-4.293 4.293a1 1 0 01-1.414-1.414L8.586 10 4.293 5.707a1 1 0 010-1.414z" clip-rule="evenodd"></path></svg>
        <span class="sr-only">Close modal</span>
      </button>
      <div class="p-6 text-center">
        <svg aria-hidden="true" class="mx-auto mb-4 w-14 h-14 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4m0 4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z"></path></svg>
        <h3 class="mb-5 text-lg font-normal text-gray-500">Are you sure you want to launch this breif ?</h3>
        <button id="btnLaunchBreif" type="button" class="text-white bg-red-600 hover:bg-red-800 focus:ring-4 focus:outline-none focus:ring-red-300 font-medium rounded-lg text-sm inline-flex items-center px-5 py-2.5 text-center mr-2">
        </button>
        <button data-modal-toggle="launch-breif-modal" type="button" class="text-gray-500 bg-white hover:bg-gray-100 focus:ring-4 focus:outline-none focus:ring-gray-200 rounded-lg border border-gray-200 text-sm font-medium px-5 py-2.5 hover:text-gray-900 focus:z-10">No, cancel</button>
      </div>
    </div>
  </div>
</div>
<script type="text/javascript">
  // hide elemment when loading page
  $("#toast-success").hide()
  $("#loadingAdd").hide()
  $("#loadingDelete").hide()
  $("#loadingLaunch").hide()
  $("#loadingEdit").hide()
  $("#dataBreif-data").hide()
  // validate info for add or edit user
  function validateAddBreif(name, file, description) {
    if(name == "" || file == null || description == "") return 0
    return 1
  }
  function validateEditBreif(name, description) {
    if(name == "" || description == "") return 0
    return 1
  }
  // edit brief
  function editBreif(id) {
    const formData = new FormData();
    let name = $("#editName").val()
    let description = $("#editDescription").val()
    let file = $("#editFile")[0].files[0]
    formData.append("name", name)
    formData.append("description", description)
    formData.append("file", file)
    formData.append("id", id)
    let validateValue = validateEditBreif(name, description);
    if(validateValue == 1) {
      $("#loadingEdit").show()
      $.ajax({
        url : "/former/update-breif",
        type: "post",
        data: formData,
        processData: false,
        contentType: false,
        success : function (response){
          getAllBreifs()
          $("#loadingEdit").hide()
          $("#btnEditToogleBreif").click()
          response.status == "success" ? toastSuccess("Breif updated successfully.") : toastError("Breif not updated !!!")
        },
        error : function (error){
          $("#loadingEdit").hide()
          toastError("Connection failed !!!")
        }
      })
    } else {
      toastError("All informations required.")
    }
  }
  // add breif
  function addbreif() {
    const formData = new FormData();
    let name = $("#name").val()
    let description = $("#description").val()
    let file = $("#file-upload")[0].files[0]
    formData.append("name", name)
    formData.append("description", description)
    formData.append("file", file)
    let validateValue = validateAddBreif(name, file, description);
    if(validateValue == 1) {
      $("#loadingAdd").show()
      $.ajax({
        url : "/former/create-breif",
        type: "post",
        data: formData,
        processData: false,
        contentType: false,
        success : function (response){
          getAllBreifs()
          $("#loadingAdd").hide()
          $("#btn-colse-model").click()
          response.status == "success" ? toastSuccess("Breif added successfully.") : toastError("Breif not added !!!")
        },
        error : function (error){
          $("#loadingAdd").hide()
          toastError("Connection failed !!!")
        }
      })
    } else {
      toastError("All informations required.")
    }
  }

  // serach by name
  function searchBreif() {
    if($("#searchName").val() != "") {
      let element = '<div class="flex justify-center overflow-hidden"><div class="mx-auto mt-10 w-8 h-8 border-4 border-dashed rounded-full animate-spin dark:border-violet-400"></div></div>'
      $("#dataBreif-data").html(element)
      $("#dataBreif-data").show()

      const formData = new FormData()
      const name = $("#searchName").val()
      formData.append("name", name)
      $.ajax({
        url : "/former/search-breif",
        type : "post",
        data: formData,
        processData: false,
        contentType: false,
        success : function (response){
          const breifs = JSON.parse(response)
          let stringHtml=""
          for (const breif of breifs) {
            stringHtml += "<tr class='bg-white border-b hover:bg-gray-50'>"
            stringHtml += "<td class='py-4 px-6'>"+breif[1]+" </td>"
            stringHtml += "<td class='py-4 px-6'> " + breif[3] + " </td>"
            stringHtml += "<td><div class='flex justify-center'>"
            stringHtml += "<button type='button' onclick='showModalDeleteBreif("+breif[0]+")' > <svg width='18px' height='18px' viewBox='0 0 18 18' xmlns='http://www.w3.org/2000/svg'> <path fill='#FF0000' d='M13 18H5a2 2 0 0 1-2-2V7a1 1 0 0 1 1-1h10a1 1 0 0 1 1 1v9a2 2 0 0 1-2 2zm3-15a1 1 0 0 1-1 1H3a1 1 0 0 1 0-2h3V1a1 1 0 0 1 1-1h4a1 1 0 0 1 1 1v1h3a1 1 0 0 1 1 1z'></path> </svg> </button>"
            stringHtml += "<button type='button' onclick='showModalEditBreif("+breif[0]+")' class='mx-4'> <svg fill='#0000FF' width='24px' height='24px' viewBox='0 0 24 24' xmlns='http://www.w3.org/2000/svg'><path d='m18.988 2.012 3 3L19.701 7.3l-3-3zM8 16h3l7.287-7.287-3-3L8 13z'></path><path d='M19 19H8.158c-.026 0-.053.01-.079.01-.033 0-.066-.009-.1-.01H5V5h6.847l2-2H5c-1.103 0-2 .896-2 2v14c0 1.104.897 2 2 2h14a2 2 0 0 0 2-2v-8.668l-2 2V19z'/></svg> </button>"
            if(breif[3] == false)
              stringHtml += "<button type='button' onclick='showModalLauchBreif(" + breif[0] + ",0)' class='ml-4 border border-red-400 rounded-lg p-1'> <svg class='w-4 h-4' xmlns='http://www.w3.org/2000/svg' viewBox='0 0 1792 1792' style='enable-background:new 0 0 1792 1792' xml:space='preserve'><path d='M1473.1 101.9H324.2c-119.7 0-217 97.3-217 217v1148.9c0 119.7 97.3 217 217 217h1148.9c119.7 0 217-97.3 217-217V318.9c0-119.7-97.3-217-217-217z'/><path d='M1390.8 534.1c-44.6-44.6-116.6-44.6-160.8 0l-498.3 499.2-187-186.6c-44.6-44.6-116.6-44.6-160.8 0-44.6 44.6-44.6 116.6 0 160.8l256.5 256c3 4.3 6.4 8.1 10.3 11.6 22.3 22.3 51.9 33.5 81.5 33.5 29.2 0 58.8-10.7 81.1-33.5 3.9-3.9 7.3-7.7 10.3-12L1391.2 695c44.2-44.2 44.2-116.3-.4-160.9z' style='fill:#fff'/></svg> </button>"
            if(breif[3] == true)
              stringHtml += "<button type='button' onclick='showModalLauchBreif(" + breif[0] + ",1)' class='ml-4 border border-green-400 rounded-lg p-1'> <svg class='w-4 h-4' xmlns='http://www.w3.org/2000/svg' viewBox='0 0 1792 1792' style='enable-background:new 0 0 1792 1792' xml:space='preserve'><path fill='green' d='M1473.1 101.9H324.2c-119.7 0-217 97.3-217 217v1148.9c0 119.7 97.3 217 217 217h1148.9c119.7 0 217-97.3 217-217V318.9c0-119.7-97.3-217-217-217z'/><path d='M1390.8 534.1c-44.6-44.6-116.6-44.6-160.8 0l-498.3 499.2-187-186.6c-44.6-44.6-116.6-44.6-160.8 0-44.6 44.6-44.6 116.6 0 160.8l256.5 256c3 4.3 6.4 8.1 10.3 11.6 22.3 22.3 51.9 33.5 81.5 33.5 29.2 0 58.8-10.7 81.1-33.5 3.9-3.9 7.3-7.7 10.3-12L1391.2 695c44.2-44.2 44.2-116.3-.4-160.9z' style='fill:#fff'/></svg> </button>"
            stringHtml += "</div>"
            stringHtml += " </td></tr>"
          }
          $("#dataBreif-data").hide()
          $("tbody").html(stringHtml)
        },
        error : function (error){
          $("#dataUser-data").hide()
          toastError("Connection failed !!!")
        }
      })
    }else {
      getAllBreifs()
    }
  }
  // get all promotions
  getAllBreifs()
  function getAllBreifs() {
    let element = '<div class="flex justify-center overflow-hidden"><div class="mx-auto mt-10 w-8 h-8 border-4 border-dashed rounded-full animate-spin dark:border-violet-400"></div></div>'
    $("#dataBreif-data").html(element)
    $("#dataBreif-data").show()
    $.ajax({
      url : "/former/get-breifs",
      type : "get",
      success : function (response){
        const breifs = JSON.parse(response)
        let stringHtml=""
        for (const breif of breifs) {
          stringHtml += "<tr class='bg-white border-b hover:bg-gray-50'>"
          stringHtml += "<td class='py-4 px-6'>"+breif[1]+" </td>"
          stringHtml += "<td class='py-4 px-6'> " + breif[3] + " </td>"
          stringHtml += "<td><div class='flex justify-center'>"
          stringHtml += "<button type='button' onclick='showModalDeleteBreif("+breif[0]+")' > <svg width='18px' height='18px' viewBox='0 0 18 18' xmlns='http://www.w3.org/2000/svg'> <path fill='#FF0000' d='M13 18H5a2 2 0 0 1-2-2V7a1 1 0 0 1 1-1h10a1 1 0 0 1 1 1v9a2 2 0 0 1-2 2zm3-15a1 1 0 0 1-1 1H3a1 1 0 0 1 0-2h3V1a1 1 0 0 1 1-1h4a1 1 0 0 1 1 1v1h3a1 1 0 0 1 1 1z'></path> </svg> </button>"
          stringHtml += "<button type='button' onclick='showModalEditBreif("+breif[0]+")' class='mx-4'> <svg fill='#0000FF' width='24px' height='24px' viewBox='0 0 24 24' xmlns='http://www.w3.org/2000/svg'><path d='m18.988 2.012 3 3L19.701 7.3l-3-3zM8 16h3l7.287-7.287-3-3L8 13z'></path><path d='M19 19H8.158c-.026 0-.053.01-.079.01-.033 0-.066-.009-.1-.01H5V5h6.847l2-2H5c-1.103 0-2 .896-2 2v14c0 1.104.897 2 2 2h14a2 2 0 0 0 2-2v-8.668l-2 2V19z'/></svg> </button>"
          if(breif[3] == false)
            stringHtml += "<button type='button' onclick='showModalLauchBreif(" + breif[0] + ",0)' class='ml-4 border border-red-400 rounded-lg p-1'> <svg class='w-4 h-4' xmlns='http://www.w3.org/2000/svg' viewBox='0 0 1792 1792' style='enable-background:new 0 0 1792 1792' xml:space='preserve'><path d='M1473.1 101.9H324.2c-119.7 0-217 97.3-217 217v1148.9c0 119.7 97.3 217 217 217h1148.9c119.7 0 217-97.3 217-217V318.9c0-119.7-97.3-217-217-217z'/><path d='M1390.8 534.1c-44.6-44.6-116.6-44.6-160.8 0l-498.3 499.2-187-186.6c-44.6-44.6-116.6-44.6-160.8 0-44.6 44.6-44.6 116.6 0 160.8l256.5 256c3 4.3 6.4 8.1 10.3 11.6 22.3 22.3 51.9 33.5 81.5 33.5 29.2 0 58.8-10.7 81.1-33.5 3.9-3.9 7.3-7.7 10.3-12L1391.2 695c44.2-44.2 44.2-116.3-.4-160.9z' style='fill:#fff'/></svg> </button>"
          if(breif[3] == true)
            stringHtml += "<button type='button' onclick='showModalLauchBreif(" + breif[0] + ",1)' class='ml-4 border border-green-400 rounded-lg p-1'> <svg class='w-4 h-4' xmlns='http://www.w3.org/2000/svg' viewBox='0 0 1792 1792' style='enable-background:new 0 0 1792 1792' xml:space='preserve'><path fill='green' d='M1473.1 101.9H324.2c-119.7 0-217 97.3-217 217v1148.9c0 119.7 97.3 217 217 217h1148.9c119.7 0 217-97.3 217-217V318.9c0-119.7-97.3-217-217-217z'/><path d='M1390.8 534.1c-44.6-44.6-116.6-44.6-160.8 0l-498.3 499.2-187-186.6c-44.6-44.6-116.6-44.6-160.8 0-44.6 44.6-44.6 116.6 0 160.8l256.5 256c3 4.3 6.4 8.1 10.3 11.6 22.3 22.3 51.9 33.5 81.5 33.5 29.2 0 58.8-10.7 81.1-33.5 3.9-3.9 7.3-7.7 10.3-12L1391.2 695c44.2-44.2 44.2-116.3-.4-160.9z' style='fill:#fff'/></svg> </button>"
          stringHtml += "</div>"
          stringHtml += " </td></tr>"
        }
        $("#dataBreif-data").hide()
        $("tbody").html(stringHtml)
      },
      error : function (error){
        $("#dataUser-data").hide()
        toastError("Connection failed !!!")
      }
    })
  }

  // launch breif
  function showModalLauchBreif(idBreif, status) {
    $("#btnLaunchBreif").attr("onclick", "launchBrief(" + idBreif + ","+status+")")
    let htmlString = ''
    htmlString += '<svg id="loadingLaunch" role="status" class="hidden inline mt-1 mr-3 w-4 h-4 text-white animate-spin" viewBox="0 0 100 101" fill="none" xmlns="http://www.w3.org/2000/svg">'
    htmlString += '<path d="M100 50.5908C100 78.2051 77.6142 100.591 50 100.591C22.3858 100.591 0 78.2051 0 50.5908C0 22.9766 22.3858 0.59082 50 0.59082C77.6142 0.59082 100 22.9766 100 50.5908ZM9.08144 50.5908C9.08144 73.1895 27.4013 91.5094 50 91.5094C72.5987 91.5094 90.9186 73.1895 90.9186 50.5908C90.9186 27.9921 72.5987 9.67226 50 9.67226C27.4013 9.67226 9.08144 27.9921 9.08144 50.5908Z" fill="#E5E7EB"/>'
    htmlString += '<path d="M93.9676 39.0409C96.393 38.4038 97.8624 35.9116 97.0079 33.5539C95.2932 28.8227 92.871 24.3692 89.8167 20.348C85.8452 15.1192 80.8826 10.7238 75.2124 7.41289C69.5422 4.10194 63.2754 1.94025 56.7698 1.05124C51.7666 0.367541 46.6976 0.446843 41.7345 1.27873C39.2613 1.69328 37.813 4.19778 38.4501 6.62326C39.0873 9.04874 41.5694 10.4717 44.0505 10.1071C47.8511 9.54855 51.7191 9.52689 55.5402 10.0491C60.8642 10.7766 65.9928 12.5457 70.6331 15.2552C75.2735 17.9648 79.3347 21.5619 82.5849 25.841C84.9175 28.9121 86.7997 32.2913 88.1811 35.8758C89.083 38.2158 91.5421 39.6781 93.9676 39.0409Z" fill="currentColor"/>'
    htmlString += '</svg>'
    if(status == 0)
    htmlString += 'Launch Breif'
    if(status == 1)
    htmlString += 'Enable Launch Breif'
    $("#btnLaunchBreif").html(htmlString)
    $("#btnToogleLaunchBreifModal").click()
  }

  // show modal for edit room
  function showModalEditBreif(idBreif) {
    fetchOneBreif(idBreif)
    $("#btnEditToogleBreif").click()
  }

  // show modal for validate delete user ( former or learner )
  function showModalDeleteBreif(idBreif) {
    $("#btnDeleteBreif").attr("onclick", "deleteBreif(" + idBreif + ")")
    $("#btnToogleDeleteBreifModal").click()
  }

  // launch breif
  function launchBrief(idBreif, status){
    const formData = new FormData()
    formData.append("id", idBreif)
    $("#loadingLaunch").show()
    $.ajax({
      url : "/former/launch-breif",
      type: "post",
      data: formData,
      contentType: 'application/json; charset=utf-8',
      processData: false,
      contentType: false,
      success : function (response){
        $("#loadingLaunch").hide()
        if (response.status === "success"){
          getAllBreifs()
          $("#btnToogleLaunchBreifModal").click()
          if(status == 0)
          toastSuccess("Breif launched successfully")
          if(status == 1)
          toastSuccess("Breif enabled launch successfully")
        }else {
          if(status == 0)
          toastError("Breif not launched !!!")
          if(status == 1)
          toastError("Breif not enable launch !!!")
        }
      },
      error : function (error){
        $("#loadingLaunch").hide()
        toastError("Connection failed !!!")
      }
    })
  }

  // delete breif
  function deleteBreif(idBreif){
    const formData = new FormData()
    formData.append("id", idBreif)
    $("#loadingDelete").show()
    $.ajax({
      url : "/former/delete-breif",
      type: "post",
      data: formData,
      contentType: 'application/json; charset=utf-8',
      processData: false,
      contentType: false,
      success : function (response){
        $("#loadingDelete").hide()
        if (response.status === "success"){
          getAllBreifs()
          $("#btnToogleDeleteBreifModal").click()
          toastSuccess("Breif deleted successfully")
        }else {
          toastError("Breif not deleted !!!")
        }
      },
      error : function (error){
        $("#loadingDelete").hide()
        toastError("Connection failed !!!")
      }
    })
  }

  function fetchOneBreif(idBreif){
    const formData = new FormData()
    formData.append("id", idBreif)
    $.ajax({
      url : "/former/get-breif",
      type : "POST",
      data:formData,
      contentType: 'application/json; charset=utf-8',
      processData: false,
      contentType: false,
      success :  function (response) {
        const breif = JSON.parse(response)[0]
        $("#editName").val(breif[1])
        $("#editDescription").val(breif[2])
        $("#image").attr("src","${pageContext.request.contextPath}/assets/images/"+ breif[4])
        $("#btnEditBreif").attr("onclick", "editBreif(" + breif[0] + ")")
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
