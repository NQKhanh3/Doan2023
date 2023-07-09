@extends('admin.layout')
@section('main-content')
<div class="row">
    <div class="col-12">
        <form id="search" action="{{ route('groupuser.list') }}" method="GET">
            <div class="row">
                <div class="col-lg-12">
                    <div class="card m-b-30">
                        <div class="card-body">
                            <div class="row">
                                <div class="col-3 form-group">
                                    <label>Id group</label>
                                    <input type="text" id="id_group" name="id_group" class="form-control" @if (!empty($inputSearch['id_group'])) value="{{ $inputSearch['id_group'] }}" @endif maxlength="50">
                                </div>
                                <div class="col-3 form-group">
                                    <label>Id user</label>
                                    <input type="text" id="id_user" name="id_user" class="form-control" @if (!empty($inputSearch['id_user'])) value="{{ $inputSearch['id_user'] }}" @endif maxlength="30">
                                </div>
                                <div class="col-3 form-group">
                                    <label>Vai trò</label>
                                    <input type="text" id="vai_tro" name="vai_tro" class="form-control" @if (!empty($inputSearch['vai_tro'])) value="{{ $inputSearch['vai_tro'] }}" @endif maxlength="30">
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-12">
                                    <div class="d-flex justify-content-end">
                                        <a href="{{ route('groupuser.list') }}" class="mr-1 btn btn-secondary waves-effect waves-light"><i class="fas fa-redo-alt"></i> Làm mới</a>
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
        <div class="card-header">
            <a href="#" class="btn btn-secondary" id="deleteall">Delete Selected</a>
        </div>
        <div class="card">
            <div class="card-body">
                <div class="table-responsive">
                    <table class="table">
                        <thead class="thead-default">
                            <tr>
                                <th><input type="checkbox" id="checkAll" ></th>
                                <th scope="col">@sortablelink('id_group', 'id group', '', ['style' => 'color: black'])</th>
                                <th scope="col">@sortablelink('id_user', 'id user', '', ['style' => 'color: black'])</th>
                                <th scope="col">@sortablelink('vai_tro', 'vai tro', '', ['style' => 'color: black'])</th>
                                <th scope="col">Hành động</th>
                            </tr>
                        </thead>
                        <tbody>
                            @if (count($groupuser) > 0)
                                @foreach ($groupuser as $groupuser)
                                <tr id="groupuser_id{{ $groupuser->id }}">
                                    <td> <input type="checkbox" value="{{ $groupuser->id }}" class="checkboxclass" name="checkbox"> </td>
                                    <td>{{ $groupuser->id_group }}</td>
                                    <td>{{ $groupuser->id_user }}</td>
                                    <td>{{ $groupuser->vai_tro }}</td>
                                    <td>
                                        <div>
                                            <a href="javascript:void(0);" onclick="editgroupuser({{$groupuser->id}})" class="btn btn-primary btn-sm waves-effect waves-light " title="Sửa" ><i class="fas fa-edit"></i></a>
                                            <a href="javascript:void(0);" class="btn btn-secondary btn-sm waves-effect waves-light btn-delete" data-id="{{ $groupuser->id }}" data-title="{{ $groupuser->id_group }}" data-toggle="tooltip" data-placement="top" title="Xóa"><i class="fas fa-trash"></i></a>
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
                @if (isset($groupusers))
                <div class="d-flex justify-content-between mt-3">
                    <div style="padding: .5rem .75rem; margin-bottom: 1rem;">
                        Hiển thị @if ($groupusers->firstItem())
                            {{ $groupusers->firstItem() }}
                        @else
                            0
                        @endif tới @if ($groupusers->lastItem())
                            {{ $groupusers->lastItem() }}
                        @else
                            0
                        @endif trong {{ $groupusers->total() }} mục
                    </div>
                    <div>
                        {{ $groupusers->onEachSide(1)->withQueryString()->links() }}
                    </div>
                </div>
                @endif
            </div>
        </div>
        <div class="modal fade" id="groupusereditmodal" tabindex="-1" aria-labelledby="groupuserModalLabel" aria-hidden="true" >
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title mt-0">Update thông tin</h5>
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                            <div class="modal-body">
                                <form id="groupuserForm">
                                    @csrf
                                    <input type="hidden" id="id" name="id" />
                                    <div class="form-group">
                                        <label for="newvaitro">Vai trò</label>
                                        <input type="text" class="form-control" id="newvaitro" />
                                    </div>
                                    <button type="submit" class="btn btn-primary">Save</button>
                                </form>
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

@section('page-groupuser-js')
<script type="text/javascript">
    $(document).ready(function() {
        $('#id_group').focus();

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
                            url : "{!! route('groupuser.delete') !!}",
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
    });

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
                url :  "{{ route('groupuser.deleteall2') }}",
                type: "DELETE",
                data: { 
                        // _token:'{{ csrf_token() }}',
                        _token:$("input[name=_token]").val(),
                        id : data 
                },
                success:function(response){
                    $.each(data,function(key,val){
                        $('#groupuser_id'+val).remove();
                    })
                }
                        
            });

        });
    });

    function editgroupuser(id)
    {
        $.get('/groupuser/'+id, function(groupuser){
           $("#id").val(groupuser.id); 
           $("#newvaitro").val(groupuser.vai_tro); 
           $("#groupusereditmodal").modal('toggle');
        });
    };
    
    $("#groupuserForm").submit(function(e){
        e.preventDefault();
        let id = $("#id").val();
        let vai_tro = $("#newvaitro").val();
        let _token = $("input[name=_token]").val();
        $.ajax({
            url :  "{{ route('groupuser.update') }}",
            type: "PUT",
            data: { id:id,
                    newvaitro:vai_tro,
                    _token:_token
                },
                success:function(response){
                    $('#groupuser_id'+response.id + ' td:nth-child(4)').text(response.vai_tro);
                    $("#groupusereditmodal").modal('toggle');
                    $("#groupuserForm")[0].reset();
                }
        });
    });
    
</script>
@endsection
