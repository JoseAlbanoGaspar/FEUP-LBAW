@extends('layouts.app')

@section('content')
<article class="myQuestions">
    <h2>Questions Asked:</h2>
    @if(count($questions) == 0)
    <p>No answers found!</p>
    @else
        @foreach($questions as $question)
        <h3>{{ $question->title }}</h3>
        <p>{{ $question->text_body }}</p>
        <p> {{ $question->date }} <p>
        @endforeach
    @endif
</article>
@endsection