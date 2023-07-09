@extends('admin.layout')
@section('main-content')
<div class="row">
    <div class="col-12">
        <form id="search" action="{{ route('group.list') }}" method="GET">
            <div class="row">
                <div class="col-lg-12">
                    <div class="card m-b-30">
                        <div class="card-body">
                            <div class="row">
                                <div class="col-3 form-group">
                                    <label>Id leader</label>
                                    <input type="text" id="id_leader" name="id_leader" class="form-control" @if (!empty($inputSearch['id_leader'])) value="{{ $inputSearch['id_leader'] }}" @endif maxlength="50">
                                </div>
                                <div class="col-3 form-group">
                                    <label>Name</label>
                                    <input type="text" id="name" name="name" class="form-control" @if (!empty($inputSearch['name'])) value="{{ $inputSearch['name'] }}" @endif maxlength="30">
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-12">
                                    <div class="d-flex justify-content-end">
                                        <a href="{{ route('group.list') }}" class="mr-1 btn btn-secondary waves-effect waves-light"><i class="fas fa-redo-alt"></i> Làm mới</a>
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
                                <th scope="col">@sortablelink('id_leader', 'id leader', '', ['style' => 'color: black'])</th>
                                <th scope="col">@sortablelink('name', 'Name', '', ['style' => 'color: black'])</th>
                                <th scope="col">Hành động</th>
                            </tr>
                        </thead>
                        <tbody>
                            @if (count($group) > 0)
                                @foreach ($group as $group)
                                <tr id="group_id{{ $group->id }}"> 
                                     <td> <input type="checkbox" value="{{ $group->id }}" class="checkboxclass" name="checkbox"> </td>
                                    <td>{{ $group->id_leader }}</td>
                                    <td>{{ $group->name }}</td>
                                    <td>
                                        <div>
                                          <a href="javascript:void(0);" onclick="editgroup({{$group->id}})" class="btn btn-primary btn-sm waves-effect waves-light " title="Sửa" ><i class="fas fa-edit"></i></a>
                                          <a href="javascript:void(0);" class="btn btn-secondary btn-sm waves-effect waves-light btn-delete" data-id="{{ $group->id }}" data-title="{{ $group->id_leader }}" data-toggle="tooltip" data-placement="top" title="Xóa"><i class="fas fa-trash"></i></a>
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
                @if (isset($groups))
                <div class="d-flex justify-content-between mt-3">
                    <div style="padding: .5rem .75rem; margin-bottom: 1rem;">
                        Hiển thị @if ($groups->firstItem())
                            {{ $groups->firstItem() }}
                        @else
                            0
                        @endif tới @if ($groups->lastItem())
                            {{ $groups->lastItem() }}
                        @else
                            0
                        @endif trong {{ $groups->total() }} mục
                    </div>
                    <div>
                        {{ $groups->onEachSide(1)->withQueryString()->links() }}
                    </div>
                </div>
                @endif
            </div>
            <div class="modal fade" id="groupeditmodal" tabindex="-1" aria-labelledby="groupModalLabel" aria-hidden="true" >
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title mt-0">Update thông tin</h5>
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                            <div class="modal-body">
                                <form id="groupForm">
                                    @csrf
                                    <input type="hidden" id="id" name="id" />
                                    <div class="form-group">
                                        <label for="newname">Name</label>
                                        <input type="text" class="form-control" id="newname" />
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

@section('page-group-js')
<script type="text/javascript">
    $(document).ready(function() {
        $('#id_leader').focus();

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
                            url : "{!! route('group.delete') !!}",
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
                url :  "{{ route('group.deleteall1') }}",
                type: "DELETE",
                data: { 
                        // _token:'{{ csrf_token() }}',
                        _token:$("input[name=_token]").val(),
                        id : data 
                },
                success:function(response){
                    $.each(data,function(key,val){
                        $('#group_id'+val).remove();
                    })
                }
                        
            });

        });
    });

    function editgroup(id)
    {
        $.get('/group/'+id, function(group){
           $("#id").val(group.id); 
           $("#newname").val(group.name); 
           $("#groupeditmodal").modal('toggle');
        });
    };
    
    $("#groupForm").submit(function(e){
        e.preventDefault();
        let id = $("#id").val();
        let name = $("#newname").val();
        let _token = $("input[name=_token]").val();
        $.ajax({
            url :  "{{ route('group.update') }}",
            type: "PUT",
            data: { id:id,
                    newname:name,
                    _token:_token
                },
                success:function(response){
                    $('#group_id'+response.id + ' td:nth-child(3)').text(response.name);
                    $("#groupeditmodal").modal('toggle');
                    $("#groupForm")[0].reset();
                }
        });
    });
</script>
@endsection
