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
      <div class="flex">
         <input id="searchName" type="text" placeholder="Search by name" class="text-gray-800 block max-w-lg w-64 shadow-sm focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm border-gray-300 rounded-md">
         <button class="">
            <svg onclick="searchPromotions()" class="ml-2" width="20" height="20" viewBox="0 0 48 48" xmlns="http://www.w3.org/2000/svg"><circle cx="19" cy="19" r="17" fill="#aedff5"/><path d="M46 48a2 2 0 0 1-1.37-.54L30 33.75a2 2 0 1 1 2.74-2.92l14.6 13.71A2 2 0 0 1 46 48Z" fill="#38b1e7"/><path d="M19 38a19 19 0 1 1 19-19 19 19 0 0 1-19 19Zm0-34a15 15 0 1 0 15 15A15 15 0 0 0 19 4Z" fill="#38b1e7"/></svg>
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
            Name
          </th>
          <th scope="col" class="py-3 px-6">
            Former
          </th>
          <th scope="col" class="py-3 px-6">
            year school
          </th>
          <th scope="col" class="py-3 px-6">
            Niveaux
          </th>
          <th scope="col" class="py-3 px-6 md:block hidden">
            Actions
          </th>
        </tr>
        </thead>
        <tbody>
        </tbody>
      </table>
      <div id="dataPromotions-data"></div>
    </div>
</div>
<%-- start modael for delete one room --%>
<button data-modal-toggle="delete-extrax-modal" hidden id="btnToogleDeletePromotionModal">show modal</button>
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
        <button id="btnDeletePromotion" type="button" class="text-white bg-red-600 hover:bg-red-800 focus:ring-4 focus:outline-none focus:ring-red-300 font-medium rounded-lg text-sm inline-flex items-center px-5 py-2.5 text-center mr-2">
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
  // hide elemment when loading page
  $("#toast-success").hide()
  $("#loadingAdd").hide()
  $("#loadingDelete").hide()
  $("#loadingEdit").hide()
  $("#dataPromotions-data").hide()
  // validate info for add or edit user
  function validateAddPromotion(name, file, year, niveau) {
    if(name == "" || year == "" || niveau == "" || file == null) return 0
    return 1
  }
  function validateEditPromotion(name, year, niveaux) {
    if(name == "" || year == "" || niveaux == "") return 0
    return 1
  }
  // edit user ( former or learner )
  function editPromotion(idPromo, idFormer) {
    const formData = new FormData();
    let name = $("#editName").val()
    let year = $("#editYear").val()
    let niveaux = $("#editNiveau").val()
    let newFormer = $("#editFormer").val()
    let image = $("#editFile")[0].files[0]
    formData.append("name", name)
    formData.append("year", year)
    formData.append("niveaux", niveaux)
    formData.append("newFormer", newFormer)
    formData.append("id", idPromo)
    formData.append("oldFormer", idFormer)
    formData.append("image", image)
    let validateValue = validateEditPromotion(name, year, niveaux);
    if(validateValue == 1) {
      toastSuccess("Promotion updated successfully.")
      $("#loadingEdit").show()
      $.ajax({
        url : "/admin/update-promotion",
        type: "post",
        data: formData,
        processData: false,
        contentType: false,
        success : function (response){
          getAllPromotions()
          $("#loadingEdit").hide()
          $("#btnEditTooglePromotion").click()
          response.status == "success" ? toastSuccess("Promotion updated successfully.") : toastError("Promotion not updated !!!")
        },
        error : function (error){
          console.log(error)
        }
      })
    } else {
      $("#loadingEdit").hide()
      toastError("All informations required.")
    }
  }
  // add user ( former or learner )
  function addPromotion() {
    const formData = new FormData();
    let name = $("#name").val()
    let former = $("#formerAdd").val()
    let file = $("#file-upload")[0].files[0]
    let year = $("#year").val()
    let niveau = $("#niveau").val()
    formData.append("name", name)
    formData.append("former", former)
    formData.append("file", file)
    formData.append("year", year)
    formData.append("niveau", niveau)
    let validateValue = validateAddPromotion(name, file, year, niveau);
    if(validateValue == 1) {
      $("#loadingAdd").show()
      $.ajax({
        url : "/admin/create-promotion",
        type: "post",
        data: formData,
        processData: false,
        contentType: false,
        success : function (response){
          getAllPromotions()
          $("#loadingAdd").hide()
          $("#btn-colse-model").click()
          response.status == "success" ? toastSuccess("Promotion added successfully.") : toastError("Promotion not added !!!")
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

  // get all formers
  getAllFormers()
  function getAllFormers() {
    $.ajax({
      url : "/admin/get-formers",
      type : "get",
      success : function (response){
        const formes = JSON.parse(response)
        let stringHtml=""
        stringHtml += "<option value='0' selected>select former</option>"
        for (const former of formes) {
          stringHtml += "<option value='"+former[0]+"'>"+ former[2] +" "+ former[1] +"</option>"
        }
        $("#formerAdd").html(stringHtml)
      },
      error : function (error){
        toastError("Connection failed !!!")
      }
    })
  }

  function searchPromotions() {
    console.log($("#searchName").val())
    if($("#searchName").val() != "") {
        let element = '<div class="flex justify-center overflow-hidden"><div class="mx-auto mt-10 w-8 h-8 border-4 border-dashed rounded-full animate-spin dark:border-violet-400"></div></div>'
        $("#dataPromotions-data").html(element)
        $("#dataPromotions-data").show()

        const formData = new FormData()
        const name = $("#searchName").val()
        formData.append("name", name)
        $.ajax({
          url : "/admin/search-promotions",
          type : "post",
          data: formData,
          processData: false,
          contentType: false,
          success : function (response){
            const promotions = JSON.parse(response)
            let stringHtml=""
            for (const promotion of promotions.promotions) {
              let formerId = 0
              let formerName = ""
              for (const former of promotions.formers) {
                if(former[5] == promotion[0]) {
                  formerId = former[0]
                  formerName = former[1]
                }
              }
              stringHtml += "<tr class='bg-white border-b hover:bg-gray-50'>"
              stringHtml += "<td class='py-4 px-6'>"+promotion[1]+" </td>"
              stringHtml += "<td class='py-4 px-6'> " + formerName + " </td>"
              stringHtml += "<td class='py-4 px-6'>"+promotion[2]+" </td>"
              stringHtml += "<td class='py-4 px-6'>"+promotion[3]+" </td>"
              stringHtml += "<td><div class='flex justify-center'>"
              stringHtml += "<button type='button' onclick='showModalDeletePromotion("+promotion[0]+","+formerId+")' > <svg width='18px' height='18px' viewBox='0 0 18 18' xmlns='http://www.w3.org/2000/svg'> <path fill='#FF0000' d='M13 18H5a2 2 0 0 1-2-2V7a1 1 0 0 1 1-1h10a1 1 0 0 1 1 1v9a2 2 0 0 1-2 2zm3-15a1 1 0 0 1-1 1H3a1 1 0 0 1 0-2h3V1a1 1 0 0 1 1-1h4a1 1 0 0 1 1 1v1h3a1 1 0 0 1 1 1z'></path> </svg> </button>"
              stringHtml += "<button type='button' onclick='showModalEditPromotion("+promotion[0]+")' class='ml-4'> <svg fill='#0000FF' width='24px' height='24px' viewBox='0 0 24 24' xmlns='http://www.w3.org/2000/svg'><path d='m18.988 2.012 3 3L19.701 7.3l-3-3zM8 16h3l7.287-7.287-3-3L8 13z'></path><path d='M19 19H8.158c-.026 0-.053.01-.079.01-.033 0-.066-.009-.1-.01H5V5h6.847l2-2H5c-1.103 0-2 .896-2 2v14c0 1.104.897 2 2 2h14a2 2 0 0 0 2-2v-8.668l-2 2V19z'/></svg> </button>"
              stringHtml += "</div>"
              stringHtml += " </td></tr>"
            }
            $("#dataPromotions-data").hide()
            $("tbody").html(stringHtml)
          },
          error : function (error){
            $("#dataUser-data").hide()
            toastError("Connection failed !!!")
          }
        })
    }else {
      getAllPromotions()
    }
  }
  // get all promotions
  getAllPromotions()
  function getAllPromotions() {
    let element = '<div class="flex justify-center overflow-hidden"><div class="mx-auto mt-10 w-8 h-8 border-4 border-dashed rounded-full animate-spin dark:border-violet-400"></div></div>'
    $("#dataPromotions-data").html(element)
    $("#dataPromotions-data").show()
    $.ajax({
      url : "/admin/get-promotions",
      type : "get",
      success : function (response){
        const promotions = JSON.parse(response)
        let stringHtml=""
        for (const promotion of promotions.promotions) {
          let formerId = 0
          let formerName = ""
          for (const former of promotions.formers) {
            if(former[5] == promotion[0]) {
              formerId = former[0]
              formerName = former[1]
            }
          }
          stringHtml += "<tr class='bg-white border-b hover:bg-gray-50'>"
          stringHtml += "<td class='py-4 px-6'>"+promotion[1]+" </td>"
          stringHtml += "<td class='py-4 px-6'> " + formerName + " </td>"
          stringHtml += "<td class='py-4 px-6'>"+promotion[2]+" </td>"
          stringHtml += "<td class='py-4 px-6'>"+promotion[3]+" </td>"
          stringHtml += "<td><div class='flex justify-center'>"
          stringHtml += "<button type='button' onclick='showModalDeletePromotion("+promotion[0]+","+formerId+")' > <svg width='18px' height='18px' viewBox='0 0 18 18' xmlns='http://www.w3.org/2000/svg'> <path fill='#FF0000' d='M13 18H5a2 2 0 0 1-2-2V7a1 1 0 0 1 1-1h10a1 1 0 0 1 1 1v9a2 2 0 0 1-2 2zm3-15a1 1 0 0 1-1 1H3a1 1 0 0 1 0-2h3V1a1 1 0 0 1 1-1h4a1 1 0 0 1 1 1v1h3a1 1 0 0 1 1 1z'></path> </svg> </button>"
          stringHtml += "<button type='button' onclick='showModalEditPromotion("+promotion[0]+","+formerId+")' class='ml-4'> <svg fill='#0000FF' width='24px' height='24px' viewBox='0 0 24 24' xmlns='http://www.w3.org/2000/svg'><path d='m18.988 2.012 3 3L19.701 7.3l-3-3zM8 16h3l7.287-7.287-3-3L8 13z'></path><path d='M19 19H8.158c-.026 0-.053.01-.079.01-.033 0-.066-.009-.1-.01H5V5h6.847l2-2H5c-1.103 0-2 .896-2 2v14c0 1.104.897 2 2 2h14a2 2 0 0 0 2-2v-8.668l-2 2V19z'/></svg> </button>"
          stringHtml += "</div>"
          stringHtml += " </td></tr>"
        }
        $("#dataPromotions-data").hide()
        $("tbody").html(stringHtml)
      },
      error : function (error){
        $("#dataUser-data").hide()
        toastError("Connection failed !!!")
      }
    })
  }
  function getAllFormersToEdit(idPromo) {
    $.ajax({
      url : "/admin/get-formers",
      type : "get",
      success : function (response){
        const formes = JSON.parse(response)
        let stringHtml=""
        let i = 0
        for (const former of formes) {
          if(former[5] == idPromo) {
            stringHtml += "<option selected value='"+former[0]+"'>"+ former[2] +" "+ former[1] +"</option>"
            i++
          }
          else
            stringHtml += "<option value='"+former[0]+"'>"+ former[2] +" "+ former[1] +"</option>"
        }
        if(i == 0) {
          stringHtml += "<option value='0' selected>select former</option>"
        } else {
          stringHtml += "<option value='0'>select former</option>"
        }
        $("#editFormer").html(stringHtml)
      },
      error : function (error){
        toastError("Connection failed !!!")
      }
    })
  }
  // show modal for edit room
  function showModalEditPromotion(idPromotion, idFormer) {
    getAllFormersToEdit(idPromotion)
    fetchOnePromotion(idPromotion, idFormer)
    $("#btnEditTooglePromotion").click()
  }

  // show modal for validate delete user ( former or learner )
  function showModalDeletePromotion(idPromotion, idFormer) {
    $("#btnDeletePromotion").attr("onclick", "deletePromotion(" + idPromotion + ", " + idFormer + ")")
    $("#btnToogleDeletePromotionModal").click()
  }

  function deletePromotion(idPromotion, idFormer){
    const formData = new FormData()
    formData.append("idPromo", idPromotion)
    formData.append("idFormer", idFormer)
    $("#loadingDelete").show()
    $.ajax({
      url : "/admin/delete-promotion",
      type: "post",
      data: formData,
      contentType: 'application/json; charset=utf-8',
      processData: false,
      contentType: false,
      success : function (response){
        $("#loadingDelete").hide()
        if (response.status === "success"){
          getAllPromotions()
          $("#btnToogleDeletePromotionModal").click()
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

  function fetchOnePromotion(idPromo, idFormer){
    const formData = new FormData()
    formData.append("id", idPromo)
    $.ajax({
      url : "/admin/get-promotion",
      type : "POST",
      data:formData,
      contentType: 'application/json; charset=utf-8',
      processData: false,
      contentType: false,
      success :  function (response) {
        const promotion = JSON.parse(response)[0]
        $("#editName").val(promotion[1])
        $("#editYear").val(promotion[2])
        $("#editNiveau").val(promotion[3])
        $("#editImage").attr("src","${pageContext.request.contextPath}/assets/images/"+ promotion[4])
        $("#btnEditPromotion").attr("onclick", "editPromotion(" + promotion[0] + ", " + idFormer + ")")
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
