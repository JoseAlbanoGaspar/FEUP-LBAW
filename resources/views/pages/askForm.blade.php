@extends('layouts.app')

@section('content')

<h2 class="m-2 my-4">Ask Question</h2>

<div class="container-sm m-5 d-flex justify-content-center">
    <div style="width: 30rem;">

    <form method="POST" action="{{ route('postQuestion') }}" enctype="multipart/form-data">
        {{ csrf_field() }}
        @method('POST')

        <!-- ID -->
        <input type="hidden" value="{{ Auth::user()->id_user }}" name="id_author" />

        <!-- title input -->
        <div class="form-outline mb-4">
        <input type="text" name="title" @if(isset($title)) value="{{$title}}" @endif class="form-control" required autofocus/>
        <label class="form-label" for="title">Title</label>
        </div>
        @if ($errors->has('title'))
        <span class="error">
            {{ $errors->first('title') }}
        </span>
        @endif

        <!-- text body input -->
        <div class="form-outline mb-4">
        <textarea  name="text_body" class="form-control" required rows="10">@if(isset($text_body)){{$text_body}}@endif
        </textarea>
        <label class="form-label" for="text_body">Question body</label>
        </div>
        @if ($errors->has('text_body'))
        <span class="error">
            {{ $errors->first('text_body') }}
        </span>
        @endif

        <!-- Tags -->
        <h5 class="row justify-content-md-center">Tags</h5>
        <div class="d-flex flex-row">
        @for ($i = 1; $i <= 4; $i++)
        <div class="form-outline mb-4">
          @php $name = "tag" . strval($i) @endphp
          <label class="form-label" for={{$name}}>Tag {{$i}}</label>
          <select id={{$name}} name={{$name}}>
            <option value="-1" selected="selected">----</option>
            @foreach($tags as $tag)
            <option value={{$tag->id_tag}}>{{$tag->name}}</option>
            @endforeach
          </select>
        </div>
        @endfor
        </div>
        


        <!-- Submit and Go Back button -->
        <div class = "m-4 mx-5 d-flex justify-content-between">
          @include('partials.goBackButton')
          <button type="submit" class="btn btn-primary btn-block">Ask</button>
        </div>

    </form>
  </div>
</div>

@endsection
