@extends('layouts.app')

@section('content')
  @include('partials.fullquestion', ['post' => $post, 'answers' => $answers])
@endsection
