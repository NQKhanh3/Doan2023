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
        <div class="card">
            <div class="card-body">
                <div class="table-responsive">
                    <table class="table">
                        <thead class="thead-default">
                            <tr>
                                <th scope="col">@sortablelink('idgroup', 'id group', '', ['style' => 'color: black'])</th>
                                <th scope="col">@sortablelink('id_user', 'id user', '', ['style' => 'color: black'])</th>
                                <th scope="col">@sortablelink('vai_tro', 'vai tro', '', ['style' => 'color: black'])</th>
                                <th scope="col">Hành động</th>
                            </tr>
                        </thead>
                        <tbody>
                            @if (count($groupuser) > 0)
                                @foreach ($groupuser as $groupuser)
                                <tr>
                                    <td>{{ $groupuser->id_group }}</td>
                                    <td>{{ $groupuser->id_user }}</td>
                                    <td>{{ $groupuser->vai_tro }}</td>
                                    <td>
                                        <div>
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
</script>
@endsection
