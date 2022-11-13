@extends('layouts.app')

@section('content')
<article class="myQuestions">
    <h2>Questions Asked:</h2>
    
    @foreach($questions as $question)
    <h3>{{ $question->title }}</h3>
    <p>{{ $question->text_body }}</p>
    <p> {{ $question->date }} <p>
    @endforeach
</article>