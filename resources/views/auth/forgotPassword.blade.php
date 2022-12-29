@extends('layouts.app')

@section('content')

    <h2 class="m-2 my-4">Password Recovery</h2>

    <div class="container-sm m-5 d-flex justify-content-center">
        <div style="width: 30rem;">
            <form method="POST" action="{{ route('forgotPasswordAction') }}">
                {{ csrf_field() }}

                <!-- Email input -->
                <div class="form-outline mb-4">
                    <input type="email" name="email" class="form-control" required autofocus/>
                    <label class="form-label" for="email">Email</label>
                </div>


                @if ($errors->has('email'))
                    <div class="alert alert-danger" role="alert">
                        {{ $errors->first('email') }}
                    </div>
                @endif

                <!-- Submit button -->
                <button type="submit" class="btn btn-primary btn-block mb-4">Submit</button>


            </form>
        </div>
    </div>

@endsection
