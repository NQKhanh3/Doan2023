<!-- @extends('admin.layout')
@section('main-content')
<form
    @if (isset($user))
        action="{{ route('user.update', ['id' => $manufacture->id]) }}"
    @else
        action="{{ route('user.store') }}"
    @endif method="POST">
    @csrf
    <div class="row">
        <div class="col-lg-12">
            <div class="card m-b-30">
                <div class="card-body">
                    <div class="row">
                        <div class="col-4 form-group">
                            <label>Email @if (!isset($user)) <span style="color: red">*</span> @endif </label>
                            <input type="text" name="email" id="email" class="form-control" required maxlength="50" placeholder="Nhập email" @isset($user) value="{{ $user->email }}" @endisset/>
                        </div>
                    </div>
                    <div class="row mt-4">
                        <div class="col-2" style="margin-left: auto">
                            <button type="submit" class="btn btn-primary waves-effect waves-light btn-block">Lưu</button>
                        </div>
                        <div class="col-2">
                            <a href="{{ route('user.list') }}" class="btn btn-secondary waves-effect waves-light btn-block">Hủy</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</form>
@endsection

@section('page-css')
<style>

</style>
@endsection

@section('page-js')
<script src="{{ asset('plugins/parsleyjs/parsley.min.js') }}"></script>
@endsection

@section('page-custom-js')
<script type="text/javascript">
    $(document).ready(function() {
        $('form').parsley();

        const Toast = Swal.mixin({
            toast: true,
            width: "20rem",
            position: 'bottom-start',
            showConfirmButton: false,
            timer: 3000,
            timerProgressBar: true,
            didOpen: (toast) => {
                toast.addEventListener('mouseenter', Swal.stopTimer)
                toast.addEventListener('mouseleave', Swal.resumeTimer)
            }
        });

        @if ($errors->any())
            @foreach ($errors->all() as $error)
                Toast.fire({
                    icon: 'error',
                    title: "{!! $error  !!}"
                });
            @endforeach
        @endif
    });
</script>
@endsection -->
