@extends('layouts.app')

@section('content')
<article class="myAnswers">
    <h2 class="m-2 my-4">Answered Questions:</h2>
    @if(count($answers) == 0)
        <p class="mx-4 my-2 fs-5">No answers found!</p>
    @else
        @each('partials.question-card', $answers, 'post')
    @endif

    <div class = "m-4 mx-5 d-flex flex-row-reverse">
        @include('partials.go-back-button')
    </div>
</article>
@endsection