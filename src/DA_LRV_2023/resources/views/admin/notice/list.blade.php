@extends('admin.layout')
@section('main-content')
<div class="row">
    <div class="col-12">
        <form id="search" action="{{ route('notice.list') }}" method="GET">
            <div class="row">
                <div class="col-lg-12">
                    <div class="card m-b-30">
                        <div class="card-body">
                            <!-- <div class="row">
                                <div class="col-3 form-group">
                                    <label>Id group</label>
                                    <input type="text" id="id_group" name="id_group" class="form-control" @if (!empty($inputSearch['id_group'])) value="{{ $inputSearch['id_group'] }}" @endif maxlength="50">
                                </div>
                                <div class="col-3 form-group">
                                    <label>Tiêu đề</label>
                                    <input type="text" id="tieu_de" name="tieu_de" class="form-control" @if (!empty($inputSearch['tieu_de'])) value="{{ $inputSearch['tieu_de'] }}" @endif maxlength="30">
                                </div>
                                <div class="col-3 form-group">
                                    <label>Nội dung</label>
                                    <input type="text" id="noi_dung" name="noi_dung" class="form-control" @if (!empty($inputSearch['noi_dung'])) value="{{ $inputSearch['noi_dung'] }}" @endif maxlength="30">
                                </div>
                                <div class="col-3 form-group">
                                    <label>Màu sắc</label>
                                    <input type="text" id="mau_sac" name="mau_sac" class="form-control" @if (!empty($inputSearch['mau_sac'])) value="{{ $inputSearch['mau_sac'] }}" @endif maxlength="30">
                                </div>
                                <div class="col-3 form-group">
                                    <label>Ngày</label>
                                    <input type="text" id="ngay" name="ngay" class="form-control" @if (!empty($inputSearch['ngay'])) value="{{ $inputSearch['ngay'] }}" @endif maxlength="30">
                                </div>
                                <div class="col-3 form-group">
                                    <label>Time</label>
                                    <input type="text" id="time" name="time" class="form-control" @if (!empty($inputSearch['time'])) value="{{ $inputSearch['time'] }}" @endif maxlength="30">
                                </div>
                                <div class="col-3 form-group">
                                    <label>Nội dung</label>
                                    <input type="text" id="lap_lai" name="lap_lai" class="form-control" @if (!empty($inputSearch['lap_lai'])) value="{{ $inputSearch['lap_lai'] }}" @endif maxlength="30">
                                </div>
                            </div> -->
                            <!-- <div class="card-header"> -->
                                <!-- <a href="#" class="btn btn-secondary" id="deleteall">Delete Selected</a>
                                <a href="#" class="btn btn-primary"   id="lammoi">Làm mới</a>
                                <a href="#" class="btn btn-info" id="timkiem">Tìm kiếm</a> -->
                                <!-- <a href="#" onclick="editnotice" class="btn btn-info" id="tiemkiem">Tìm kiếm</i></a> -->
                            
                            <!-- </div> -->
                            <div class="row">
                                <!-- <div class="col-12"> -->
                                    <div class="d-flex justify-content-end">
                                        <a href="#" class="mr-1 btn btn-danger waves-effect waves-light" id="deleteall"><i class="fas fa-trash"></i> Delete Selected</a>
                                        <a href="{{ route('notice.list') }}" class="mr-1 btn btn-secondary waves-effect waves-light"><i class="fas fa-redo-alt"></i> Làm mới</a>
                                        <a href="#" class="mr-1 btn btn-info waves-effect waves-light" id="timkiem"><i class="fas fa-search"></i> Tìm kiếm</a>
                                        <a href="#" class="btn btn-success" id="excel"><i class="fas fa-file-export"></i> Export Excel</a>
                                        <!-- <button type="submit" class="btn btn-info waves-effect waves-light">
                                            <i class="fas fa-search"></i> Tìm kiếm
                                        </button> -->
                                    </div>
                                <!-- </div> -->
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
                                <th><input type="checkbox" id="checkAll" ></th>
                                <th scope="col">@sortablelink('id_group', 'id group', '', ['style' => 'color: black'])</th>
                                <th scope="col">@sortablelink('tieu_de', 'Tiêu đề', '', ['style' => 'color: black'])</th>
                                <th scope="col">@sortablelink('noi_dung', 'Nội dung', '', ['style' => 'color: black'])</th>
                                <th scope="col">@sortablelink('mau_sac', 'Màu sắc', '', ['style' => 'color: black'])</th>
                                <th scope="col">@sortablelink('ngay', 'Ngày', '', ['style' => 'color: black'])</th>
                                <th scope="col">@sortablelink('time', 'Time', '', ['style' => 'color: black'])</th>
                                <th scope="col">@sortablelink('lap_lai', 'Lặp lại', '', ['style' => 'color: black'])</th>
                                <th scope="col">Hành động</th>
                            </tr>
                        </thead>
                        <tbody>
                            @if (count($notice) > 0)
                                @foreach ($notice as $notice)
                                <tr id="notice_id{{ $notice->id }}">
                                    <td> <input type="checkbox" value="{{ $notice->id }}" class="checkboxclass" name="checkbox"> </td>
                                    <td>{{ $notice->id_group }}</td>
                                    <td>{{ $notice->tieu_de }}</td>
                                    <td>{{ $notice->noi_dung }}</td>
                                    <td>{{ $notice->mau_sac }}</td>
                                    <td>{{ $notice->ngay }}</td>
                                    <td>{{ $notice->time }}</td>
                                    <td>{{ $notice->lap_lai }}</td>
                                    <td>
                                        <div>
                                            <a href="javascript:void(0);" onclick="editnotice({{$notice->id}})" class="btn btn-primary btn-sm waves-effect waves-light " title="Sửa" ><i class="fas fa-edit"></i></a>
                                            <a href="javascript:void(0);" class="btn btn-secondary btn-sm waves-effect waves-light btn-delete" data-id="{{ $notice->id }}" data-title="{{ $notice->id_group }}" data-toggle="tooltip" data-placement="top" title="Xóa"><i class="fas fa-trash"></i></a>
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
                @if (isset($notices))
                <div class="d-flex justify-content-between mt-3">
                    <div style="padding: .5rem .75rem; margin-bottom: 1rem;">
                        Hiển thị @if ($notices->firstItem())
                            {{ $notices->firstItem() }}
                        @else
                            0
                        @endif tới @if ($notices->lastItem())
                            {{ $notices->lastItem() }}
                        @else
                            0
                        @endif trong {{ $notices->total() }} mục
                    </div>
                    <div>
                        {{ $notices->onEachSide(1)->withQueryString()->links() }}
                    </div>
                </div>
                @endif
            </div>
        </div>
        <div class="modal fade" id="noticeeditmodal" tabindex="-1" aria-labelledby="noticeModalLabel" aria-hidden="true" >
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title mt-0">Update thông tin</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <form id="noticeForm">
                            @csrf
                            <input type="hidden" id="id" name="id" />
                            <div class="form-group">
                                <label for="newtieude">Tiêu đề</label>
                                <input type="text" class="form-control" id="newtieude" />
                            </div>
                            <div class="form-group">
                                <label for="newnoidung">Nội dung</label>
                                <input type="text" cols="50" rows="10" class="form-control" id="newnoidung" />
                                <!-- <textarea class="form-control" cols="50" rows="10" id="newnoidung"></textarea> -->
                            </div>
                            <div class="form-group">
                                <label for="newmausac">Màu sắc</label>
                                <input type="color" class="form-control" id="newmausac" />
                            </div>
                            <div class="form-group">
                                <label for="newngay">Ngày</label>
                                <input type="date" class="form-control" id="newngay" />
                            </div>
                            <div class="form-group">
                                <label for="newtime">Time</label>
                                <input type="time" class="form-control" id="newtime" />
                            </div>
                            <div class="form-group">
                                <label for="newlaplai">Lặp lại</label>
                                <input type="text" class="form-control" id="newlaplai" />
                            </div>
                            <button type="submit" class="btn btn-primary">Save</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <div class="modal fade" id="noticeeditmodal1" tabindex="-1" aria-labelledby="noticeModalLabel1" aria-hidden="true" >
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title mt-0">Tìm kiếm thông tin</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <form id="noticeForm1">
                            @csrf
                            <input type="hidden" id="id1" name="id1" />
                            <!-- <div class="form-group">
                                <label for="newtieude1">Tiêu đề</label>
                                <input type="text" class="form-control" id="newtieude1" />
                            </div>
                            <div class="form-group">
                                <label for="newnoidung1">Nội dung</label>
                                <input type="text" class="form-control" id="newnoidung1" />
                            </div>
                            <div class="form-group">
                                <label for="newmausac1">Màu sắc</label>
                                <input type="text" class="form-control" id="newmausac1" />
                            </div>
                            <div class="form-group">
                                <label for="newngay1">Ngày</label>
                                <input type="text" class="form-control" id="newngay1" />
                            </div>
                            <div class="form-group">
                                <label for="newtime1">Time</label>
                                <input type="text" class="form-control" id="newtime1" />
                            </div>
                            <div class="form-group">
                                <label for="newlaplai1">Lặp lại</label>
                                <input type="text" class="form-control" id="newlaplai1" />
                            </div> -->
                            <!-- <div class="row"> -->
                                <div class="form-group">
                                    <label>Id group</label>
                                    <input type="text" id="id_group" name="id_group" class="form-control" @if (!empty($inputSearch['id_group'])) value="{{ $inputSearch['id_group'] }}" @endif maxlength="10">
                                </div>
                                <div class="form-group">
                                    <label>Tiêu đề</label>
                                    <input type="text" id="tieu_de" name="tieu_de" class="form-control" @if (!empty($inputSearch['tieu_de'])) value="{{ $inputSearch['tieu_de'] }}" @endif maxlength="50">
                                </div>
                                <!-- <div class="form-group">
                                    <label>Nội dung</label>
                                    <input type="longtext" id="noi_dung" name="noi_dung" class="form-control" @if (!empty($inputSearch['noi_dung'])) value="{{ $inputSearch['noi_dung'] }}" @endif maxlength="30">
                                </div> -->
                                <!-- <div class="form-group">
                                    <label>Màu sắc</label>
                                    <input type="color" id="mau_sac" name="mau_sac" class="form-control" @if (!empty($inputSearch['mau_sac'])) value="{{ $inputSearch['mau_sac'] }}" @endif maxlength="50">
                                </div> -->
                                <div class="form-group">
                                    <label>Ngày</label>
                                    <input type="date" id="ngay" name="ngay" class="form-control" @if (!empty($inputSearch['ngay'])) value="{{ $inputSearch['ngay'] }}" @endif maxlength="30">
                                </div>
                                <div class="form-group">
                                    <label>Time</label>
                                    <input type="time" id="time" name="time" class="form-control" @if (!empty($inputSearch['time'])) value="{{ $inputSearch['time'] }}" @endif maxlength="30">
                                </div>
                                <div class="form-group">
                                    <label>Lặp lại</label>
                                    <input type="text" id="lap_lai" name="lap_lai" class="form-control" @if (!empty($inputSearch['lap_lai'])) value="{{ $inputSearch['lap_lai'] }}" @endif maxlength="10">
                                </div>
                            <!-- </div> -->
                            <button type="submit" class="btn btn-primary">Save</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
        
        <div class="modal fade" id="noticeeditmodal2" tabindex="-1" aria-labelledby="noticeModalLabel2" aria-hidden="true" >
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title mt-0">Export Excel</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <form id="noticeForm2">
                            @csrf
                            <input type="hidden" id="id2" name="id2" />
                                <div class="form-group">
                                    <label>Từ ngày</label>
                                    <input type="date" id="ngay" name="ngay" class="form-control" @if (!empty($inputSearch['ngay'])) value="{{ $inputSearch['ngay'] }}" @endif maxlength="30">
                                </div>
                                <div class="form-group">
                                    <label>Đến ngày</label>
                                    <input type="date" id="ngay2" name="ngay" class="form-control" @if (!empty($inputSearch['ngay'])) value="{{ $inputSearch['ngay'] }}" @endif maxlength="30">
                                </div>
                                <div class="form-group">
                                    <label>Từ time</label>
                                    <input type="time" id="time1" name="time1" class="form-control" @if (!empty($inputSearch['time'])) value="{{ $inputSearch['time'] }}" @endif maxlength="30">
                                </div>
                                <div class="form-group">
                                    <label>Đến time</label>
                                    <input type="time" id="time2" name="time2" class="form-control" @if (!empty($inputSearch['time'])) value="{{ $inputSearch['time'] }}" @endif maxlength="30">
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

@section('page-notice-js')
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
                            url : "{!! route('notice.delete') !!}",
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
                url :  "{{ route('notice.deleteall3') }}",
                type: "DELETE",
                data: { 
                        // _token:'{{ csrf_token() }}',
                        _token:$("input[name=_token]").val(),
                        id : data 
                },
                success:function(response){
                    $.each(data,function(key,val){
                        $('#notice_id'+val).remove();
                    })
                }
                        
            });
        });

        // $("#timkiem").click(function(e){

        // });
    });

    $(function(e){
        $("#timkiem").click(function(e){
            $.get('/notice1/'+id, function(notice){
                // $("#id1").val(notice.id); 
                // $("#newtieude1").val(notice.tieu_de);
                // $("#newnoidung1").val(notice.noi_dung); 
                // $("#newmausac1").val(notice.mau_sac); 
                // $("#newngay1").val(notice.ngay); 
                // $("#newtime1").val(notice.time); 
                // $("#newlaplai1").val(notice.lap_lai); 
                $("#noticeeditmodal1").modal('toggle');
            });
            // alert("Sở thích là: " );
        });
    });

    $(function(e){
        $("#excel").click(function(e){
            $.get('/notice2/'+id, function(notice){
                $("#noticeeditmodal2").modal('toggle');
            });
        });
    });


    function editnotice(id)
    {
        $.get('/notice/'+id, function(notice){
           $("#id").val(notice.id); 
           $("#newtieude").val(notice.tieu_de);
           $("#newnoidung").val(notice.noi_dung); 
           $("#newmausac").val(notice.mau_sac); 
           $("#newngay").val(notice.ngay); 
           $("#newtime").val(notice.time); 
           $("#newlaplai").val(notice.lap_lai); 
           $("#noticeeditmodal").modal('toggle');
        });
    };
    
    $("#noticeForm").submit(function(e){
        e.preventDefault();
        let id = $("#id").val();
        let tieu_de = $("#newtieude").val();
        let noi_dung = $("#newnoidung").val();
        let mau_sac = $("#newmausac").val();
        let ngay = $("#newngay").val();
        let time = $("#newtime").val();
        let lap_lai = $("#newlaplai").val();
        let _token = $("input[name=_token]").val();
        $.ajax({
            url :  "{{ route('notice.update') }}",
            type: "PUT",
            data: { id:id,
                    newtieude:tieu_de,
                    newnoidung:noi_dung,
                    newmausac:mau_sac,
                    newngay:ngay,
                    newtime:time,
                    newlaplai:lap_lai,
                    _token:_token
                },
                success:function(response){
                    $('#notice_id'+response.id + ' td:nth-child(3)').text(response.tieu_de);
                    $('#notice_id'+response.id + ' td:nth-child(4)').text(response.noi_dung);
                    $('#notice_id'+response.id + ' td:nth-child(5)').text(response.mau_sac);
                    $('#notice_id'+response.id + ' td:nth-child(6)').text(response.ngay);
                    $('#notice_id'+response.id + ' td:nth-child(7)').text(response.time);
                    $('#notice_id'+response.id + ' td:nth-child(8)').text(response.lap_lai);
                    $("#noticeeditmodal").modal('toggle');
                    $("#noticeForm")[0].reset();
                }
        });
    });

</script>
@endsection
