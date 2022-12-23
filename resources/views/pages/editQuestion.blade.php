@extends('layouts.app')

@section('content')

<h2 class="m-2 my-4">Edit Question</h2>

<div class="container-sm m-5 d-flex justify-content-center">
    <div style="width: 30rem;">

    <form method="post" action="{{ route('updatePost') }}" enctype="multipart/form-data">
        @method('PATCH')
        {{ csrf_field() }}

        <!-- ID FALTA AINDA-->
        <input type="hidden" value="{{ $post->id_post }}" name="id_post">
        <input type="hidden" value="{{ Auth::user()->id_user }}" name="id_author" />

        <!-- title input -->
        <div class="form-outline mb-4">
        <input type="text" name="title" class="form-control" value="{{$post->question->title}}" autofocus/>
        <label class="form-label" for="title">Title</label>
        </div>
        @if ($errors->has('title'))
        <span class="error">
            {{ $errors->first('title') }}
        </span>
        @endif

        <!-- text body input -->
        <div class="form-outline mb-4">
        <textarea name="text_body" class="form-control" rows="10">{{$post->text_body}}</textarea>
        <label class="form-label" for="text_body">Question body</label>
        </div>
        @if ($errors->has('text_body'))
        <span class="error">
            {{ $errors->first('text_body') }}
        </span>
        @endif

        <!-- Tags $post->question->tags-->
        <h5 class="row justify-content-md-center">Tags</h5>

        <div class="d-flex flex-row">
        @php $k = 1 @endphp
        @foreach($post->question->tags as $questionTag)
        <div class="form-outline mb-4">
          @php $name = "tag" . strval($k) @endphp
          <label class="form-label" for={{$name}}>Tag {{$k}}</label>
          <select id={{$name}} name={{$name}}>
            <option value="-1">----</option>  <!-- option to remove tag -->
            @foreach($tags as $tag)
              @if($questionTag->name == $tag->name)
              <option value={{$tag->id_tag}} selected="selected">{{$tag->name}}</option>
              @else
              <option value={{$tag->id_tag}}>{{$tag->name}}</option>
              @endif
            @endforeach
          </select>
          @php $k += 1 @endphp
        </div>
        @endforeach
        @for ($i = $k; $i <= 4; $i++)
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
          <button type="submit" class="btn btn-primary btn-block">Submit</button>
        </div>

    </form>
  </div>
</div>

@endsection
