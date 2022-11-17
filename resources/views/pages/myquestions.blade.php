@extends('layouts.app')

@section('content')
<article class="myQuestions">
    <h2>Questions Asked:</h2>
    @if(count($questions) == 0)
        <p>No answers found!</p>
    @else
        @each('partials.question-card', $questions, 'post')
    @endif
</article>
@endsection