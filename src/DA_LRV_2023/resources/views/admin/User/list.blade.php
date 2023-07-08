@extends('admin.layout')
@section('main-content')
<div class="row">
    <div class="col-12">
        <form id="search" action="{{ route('user.list') }}" method="GET">
            <div class="row">
                <div class="col-lg-12">
                    <div class="card m-b-30">
                        <div class="card-body">
                            <div class="row">
                                <div class="col-3 form-group">
                                    <label>Username</label>
                                    <input type="text" id="username" name="username" class="form-control" @if (!empty($inputSearch['username'])) value="{{ $inputSearch['username'] }}" @endif maxlength="50">
                                </div>
                                <div class="col-3 form-group">
                                    <label>Email</label>
                                    <input type="text" id="email" name="email" class="form-control" @if (!empty($inputSearch['email'])) value="{{ $inputSearch['email'] }}" @endif maxlength="30">
                                </div>
                                <!-- <div class="col-3 form-group">
                                    <label>Số điện thoại</label>
                                    <input type="text" id="sdt" name="sdt" class="form-control" @if (!empty($inputSearch['sdt'])) value="{{ $inputSearch['sdt'] }}" @endif maxlength="10">
                                </div> -->
                                <div class="col-3 form-group">
                                    <label>Tình trạng</label>
                                    <select class="form-control" id="bi_khoa" name="bi_khoa">
                                        <option selected disabled>Chọn tình trạng</option>
                                        <option @if ($inputSearch['bi_khoa'] == '0') selected @endif value="0">Không khóa</option>
                                        <option @if ($inputSearch['bi_khoa'] == 1) selected @endif value="1">Bị khóa</option>
                                    </select>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-12">
                                    <div class="d-flex justify-content-end">
                                        <a href="{{ route('user.list') }}" class="mr-1 btn btn-secondary waves-effect waves-light"><i class="fas fa-redo-alt"></i> Làm mới</a>
                                        <button type="submit" class="btn btn-info waves-effect waves-light">
                                            <i class="fas fa-search"></i> Tìm kiếm
                                        </button>
                                    </div>
                                </div>
                             </div>
                        </div>
                    </div>
                </div>
            </div>
        </form>

        <!-- <input type="button" id="btn1" value="Check All"/>
        <input type="button" id="btn2" value="Uncheck All"/>
        <input type="button" id="btn3" value="Mở Khóa"/>
        <input type="button" id="btn3" value="Khóa"/>
        <input type="button" id="btn3" value="Xóa"/> -->
        <div class="card-header">
            <a href="#" class="btn btn-secondary" id="deleteall">Delete Selected</a>
            <a href="#" class="btn btn-danger" id="lockall">Lock</a>
            <a href="#" class="btn btn-success" id="unlockall">Unlock</a>
        </div>

        <div class="card">
            <div class="card-body">
                <div class="table-responsive">
                    <table class="table">
                        <thead class="thead-default">
                            <tr>
                                <!-- <th scope="col">Checkbox</th> -->
                                <th><input type="checkbox" id="checkAll" ></th>
                                <th scope="col">@sortablelink('username', 'username', '', ['style' => 'color: black'])</th>
                                <th scope="col">@sortablelink('email', 'Email', '', ['style' => 'color: black'])</th>
                                <!-- <th scope="col">@sortablelink('sdt', 'Số điện thoại', '', ['style' => 'color: black'])</th> -->
                                <th scope="col">@sortablelink('bi_khoa', 'Tình trạng', '', ['style' => 'color: black'])</th>
                                <th scope="col">Hành động</th>
                            </tr>
                        </thead>
                        <tbody>
                            @if (count($user) > 0)
                                @foreach ($user as $user)
                                <tr id="user_id{{ $user->id }}">
                                    <td> <input type="checkbox" value="{{ $user->id }}" class="checkboxclass" name="checkbox"> </td>
                                    <td>{{ $user->username }}</td>
                                    <td>{{ $user->email }}</td>
                                    <!-- <td>{{ $user->sdt }}</td> -->
                                    <td>
                                        @if ($user->bi_khoa == 1)
                                            <span class="badge badge-danger font-12">Bị khóa</span>
                                        @else
                                            <span class="badge badge-success font-12">Không khóa</span>
                                        @endif
                                    </td>
                                    <td>
                                        <div>
                                            <a href="javascript:void(0);" data-id="{{ $user->id }}" data-lock="{{$user->bi_khoa}}" data-title="{{ $user->email }}" data-toggle="tooltip" data-placement="top"
                                            @if ($user->bi_khoa == 1)
                                                class="btn btn-success btn-sm waves-effect waves-light btn-lock" title="Mở khóa"><i class="fas fa-lock-open"></i>
                                            @else
                                                class="btn btn-danger btn-sm waves-effect waves-light btn-lock" title="Khóa"><i class="fas fa-lock"></i>
                                            @endif </a>
                                            <a href="javascript:void(0);" class="btn btn-info btn-sm waves-effect waves-light btn-change" data-toggle="tooltip" data-placement="top" title="Đổi mật khẩu" data-id="{{ $user->id }}"><i class="fas fa-key"></i></a>
                                            <a href="javascript:void(0);" class="btn btn-secondary btn-sm waves-effect waves-light btn-delete" data-id="{{ $user->id }}" data-title="{{ $user->email }}" data-toggle="tooltip" data-placement="top" title="Xóa"><i class="fas fa-trash"></i></a>
                                            <a href="javascript:void(0);" onclick="edituser({{$user->id}})" class="btn btn-primary btn-sm waves-effect waves-light " title="Sửa" ><i class="fas fa-edit"></i></a>
                                        </div>
                                    </td>
                                </tr>
                                @endforeach
                            @else
                                @if ($isSearch)
                                    @include('admin.partials.no-data-search')
                                @else
                                    @include('admin.partials.no-data')
                                @endif
                            @endif
                        </tbody>
                    </table>
                </div>
                @if (isset($users))
                <div class="d-flex justify-content-between mt-3">
                    <div style="padding: .5rem .75rem; margin-bottom: 1rem;">
                        Hiển thị @if ($users->firstItem())
                            {{ $users->firstItem() }}
                        @else
                            0
                        @endif tới @if ($users->lastItem())
                            {{ $users->lastItem() }}
                        @else
                            0
                        @endif trong {{ $users->total() }} mục
                    </div>
                    <div>
                        {{ $users->onEachSide(1)->withQueryString()->links() }}
                    </div>
                </div>
                @endif
                <div id="change-pass" class="modal fade bs-example-modal-center" tabindex="-1" role="dialog" aria-hidden="true">
                    <div class="modal-dialog modal-dialog-centered dialogExport">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h4 class="modal-title mt-0">Đổi mật khẩu</h4>
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                            <div class="modal-body">
                                <form action="{{ route('user.change-pass') }}" method="POST">
                                    @csrf
                                    <div class="row">
                                        <div class="col-12">
                                            <div class="row">
                                                <input type="hidden" name="id" id="user-id">
                                                <div class="col-md-6">
                                                    <div class="form-group">
                                                        <label for="new_pass" class="control-label">Mật khẩu mới <span style="color: red">*</span></label>
                                                        <input type="password" class="form-control" id="new_pass" name="new_pass" minlength="6" maxlength="20" required placeholder="Nhập mật khẩu mới">
                                                        <span toggle="#new_pass" class="fa fa-eye new_pass eyes"></span>
                                                    </div>
                                                </div>
                                                <div class="col-md-6">
                                                    <div class="form-group">
                                                        <label for="confirm_pass" class="control-label">Xác nhận mật khẩu <span style="color: red">*</span></label>
                                                        <input type="password" class="form-control" id="confirm_pass" required minlength="6" maxlength="20" placeholder="Nhập xác nhận mật khẩu">
                                                        <span toggle="#confirm_pass" class="fa fa-eye confirm_pass eyes"></span>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="row mt-2">
                                                <div class="col-12" style="margin-left: auto;">
                                                    <div class="row">
                                                        <div class="col-6 pr-0">
                                                            <a href="javascript:void(0);" class="btn btn-secondary waves-effect waves-light btn-block" data-dismiss="modal">Hủy</a>
                                                        </div>
                                                        <div class="col-6">
                                                            <button type="submit" class="btn btn-success waves-effect waves-light btn-block">Lưu</button>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- <div id="update" class="modal fade bs-example-modal-center" tabindex="-1" role="dialog" aria-hidden="true">
                    <div class="modal-dialog modal-dialog-centered dialogExport">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h4 class="modal-title mt-0">Update thông tin</h4>
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                            <div class="modal-body">
                                <form id="useredit">
                                    @csrf
                                    <div class="row">
                                        <div class="col-12">
                                            <div class="row">
                                                <input type="hidden" name="id" id="user-id">
                                                <div class="col-md-12">
                                                    <div class="form-group">
                                                        <label for="new_username" class="control-label">Username</label>
                                                        <input type="text" class="form-control" id="new_username" name="new_username" minlength="6" maxlength="50" >
                                                        <span toggle="#new_username"></span>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="row mt-2">
                                                <div class="col-12" style="margin-left: auto;">
                                                    <div class="row">
                                                        <div class="col-6 pr-0">
                                                            <a href="javascript:void(0);" class="btn btn-secondary waves-effect waves-light btn-block" data-dismiss="modal">Hủy</a>
                                                        </div>
                                                        <div class="col-6">
                                                            <button type="submit" class="btn btn-success waves-effect waves-light btn-block">Lưu</button>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div> -->
                <div class="modal fade" id="usereditmodal" tabindex="-1" aria-labelledby="userModalLabel" aria-hidden="true" >
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title mt-0">Update thông tin</h5>
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                            <div class="modal-body">
                                <form id="userForm">
                                    @csrf
                                    <input type="hidden" id="id" name="id" />
                                    <div class="form-group">
                                        <label for="newusername">User name</label>
                                        <input type="text" class="form-control" id="newusername" />
                                    </div>
                                    <button type="submit" class="btn btn-primary">Save</button>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
@endsection

@section('page-css')
<style>
    .eyes {
        float: right;
        margin-top: -24px;
        padding-right: 8px;
        opacity: 0.8;
    }
</style>
@endsection

@section('page-js')
@endsection

@section('page-user-js')
<script type="text/javascript">
    $(document).ready(function() {
        $('#username').focus();

        $('.btn-change').click(function() {
            var mId = $(this).data('id');
            $("#change-pass").modal('show');
            $('#user-id').val(mId);
        });

        $(".new_pass").click(function() {
            $(this).toggleClass("fa-eye fa-eye-slash");
            var input = $($(this).attr("toggle"));
            if (input.attr("type") == "password") {
                input.attr("type", "text");
            } else {
                input.attr("type", "password");
            }
        });

        $(".confirm_pass").click(function() {
            $(this).toggleClass("fa-eye fa-eye-slash");
            var input = $($(this).attr("toggle"));
            if (input.attr("type") == "password") {
                input.attr("type", "text");
            } else {
                input.attr("type", "password");
            }
        });

        $('#confirm_pass').keyup(function() {
            if ($('#new_pass').val() == $('#confirm_pass').val()) {
                $('#confirm_pass').css('border-color', '#69d069');
                $('#confirm_pass')[0].setCustomValidity('');
            } else {
                $('#confirm_pass')[0].setCustomValidity("Password Don't Match");
                $('#confirm_pass').css('border-color', '#f58787');
            }
        });

        $('.btn-lock').click(function() {
            var mId = $(this).data("id");
            var mTitle = $(this).data("title");
            var _isLock = $(this).data("lock");
            var str = (_isLock == "1") ? "mở khóa" : "khóa";
            Swal.fire({
                title: `Bạn có chắc ${str} tài khoản "${mTitle}" ?`,
                icon: 'warning',
                showCancelButton: true,
                confirmButtonText: 'Có',
                cancelButtonText: 'Không',
                reverseButtons: true,
                confirmButtonColor: "#02c58d",
                cancelButtonColor: "#fc3b3b",
                preConfirm: () => {
                    return new Promise(function (resolve) {
                        $.ajaxSetup({
                            headers: {
                                'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
                            }
                        });

                        $.ajax({
                            url : "{!! route('user.lock') !!}",
                            type: "POST",
                            data: { id : mId }
                        }).done(function (res) {
                            Swal.fire(
                                `${res.title}`,
                                `${res.msg}`,
                                `${res.status}`,
                            ).then(() => {
                                location.reload();
                            });
                        })
                    })
                }
            });
        });

        $('.btn-delete').click(function() {
            var mId = $(this).data("id");
            var mTitle = $(this).data("title");
            Swal.fire({
                title: `Bạn có chắc xóa "${mTitle}" ?`,
                icon: 'warning',
                showCancelButton: true,
                confirmButtonText: 'Có',
                cancelButtonText: 'Không',
                reverseButtons: true,
                confirmButtonColor: "#02c58d",
                cancelButtonColor: "#fc3b3b",
                preConfirm: () => {
                    return new Promise(function (resolve) {
                        $.ajaxSetup({
                            headers: {
                                'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
                            }
                        });

                        $.ajax({
                            url : "{!! route('user.delete') !!}",
                            type: "DELETE",
                            data: { id : mId }
                        }).done(function (response) {
                            Swal.fire(
                                `${response.title}`,
                                `${response.msg}`,
                                `${response.status}`,
                            ).then(() => {
                                location.reload();
                            });
                        })
                    })
                }
            });
        });

        // $('.btn-update').click(function() {
        //     var mId = $(this).data('id');
        //     $("#update").modal('show');
        //     $('#user-id').val(mId);
        // });

        // $('input[type="checkbox"]').change(function() {
           
        // //    var $this = $(this);
        //    var checkbox = document.getElementsByName('checkbox');
        //         var result = "";
                 
        //         // Lặp qua từng checkbox để lấy giá trị
        //         for (var i = 0; i < checkbox.length; i++){
        //             if (checkbox[i].checked === true){
        //                 result += ' [' + checkbox[i].value + ']';
        //             }
        //         }
                 
        //         // In ra kết quả
        //         // alert("Sở thích là: " + result);

        //     // if( $this.is(":checked") ) {
               
        //     // };

        //  });
    });
    // document.getElementById("btn1").onclick = function () 
    //         {
    //             // Lấy danh sách checkbox
    //             var checkboxes = document.getElementsByName('checkbox[]');
 
    //             // Lặp và thiết lập checked
    //             for (var i = 0; i < checkboxes.length; i++){
    //                 checkboxes[i].checked = true;
    //             }
    //         };
    // document.getElementById("btn2").onclick = function () 
    //         {
    //             // Lấy danh sách checkbox
    //             var checkboxes = document.getElementsByName('checkbox[]');

    //             // Lặp và thiết lập Uncheck
    //             for (var i = 0; i < checkboxes.length; i++){
    //                 checkboxes[i].checked = false;
    //             }
    //         };
    
    //  document.getElementById("btn3").onclick = function () 
    //         {
    //             // Lấy danh sách checkbox
    //             var checkboxes = document.getElementsByName('checkbox[]');

    //             // Lặp và thiết lập Uncheck
    //             for (var i = 0; i < checkboxes.length; i++){
    //                 if( checkboxes[i].checked == true ){
    //                 }
    //             }
    //         };
    $(function(e){
        $("#checkAll").click(function(){
            $(".checkboxclass").prop('checked',$(this).prop('checked'));
        });

        $("#deleteall").click(function(e){
            e.preventDefault();
            var data = [];

            $("input:checkbox[name=checkbox]:checked").each(function(){
                data.push($(this).val());
            });

             $.ajax({
                url :  "{{ route('user.deleteall') }}",
                type: "DELETE",
                data: { 
                        // _token:'{{ csrf_token() }}',
                        _token:$("input[name=_token]").val(),
                        id : data 
                },
                success:function(response){
                    $.each(data,function(key,val){
                        $('#user_id'+val).remove();
                    })
                }
                        
            });

        });

        $("#lockall").click(function(e){
            e.preventDefault();
            var data = [];

            $("input:checkbox[name=checkbox]:checked").each(function(){
                data.push($(this).val());
            });

             $.ajax({
                url :  "{{ route('user.lockall') }}",
                type: "PUT",
                data: { 
                        _token:$("input[name=_token]").val(),
                        id : data
                },
                success:function(response){
                    $.each(data,function(key,val){
                        $('#user_id'+val).update();
                    })
                }
                        
            });
        });

        $("#unlockall").click(function(e){
            e.preventDefault();
            var data = [];

            $("input:checkbox[name=checkbox]:checked").each(function(){
                data.push($(this).val());
            });

             $.ajax({
                url :  "{{ route('user.unlockall') }}",
                type: "PUT",
                data: {  
                        id : data ,
                        _token:$("input[name=_token]").val()
                },
                success:function(response){
                    $.each(data,function(key,val){
                        $('#user_id'+val).update();
                    })
                }
                        
            });
        });

    });

    function edituser(id)
    {
        $.get('/user/'+id, function(user){
           $("#id").val(user.id); 
           $("#newusername").val(user.username); 
           $("#usereditmodal").modal('toggle');
        });
    };
    
    $("#userForm").submit(function(e){
        e.preventDefault();
        let id = $("#id").val();
        let username = $("#newusername").val();
        let _token = $("input[name=_token]").val();
        $.ajax({
            url :  "{{ route('user.update') }}",
            type: "PUT",
            data: { id:id,
                    newusername:username,
                    _token:_token
                },
                success:function(response){
                    $('#user_id'+response.id + ' td:nth-child(2)').text(response.username);
                    $("#usereditmodal").modal('toggle');
                    $("#userForm")[0].reset();
                }
        });
    });
    
</script>
@endsection
