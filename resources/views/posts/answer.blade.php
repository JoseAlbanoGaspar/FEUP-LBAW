@extends('layouts.app')

@section('content')
<article class="myAnswers">
    <h2>Answered Questions:</h2>
    @if(count($answers) == 0)
    <p>No answers found!</p>
    @else
        @foreach($answers as $answer)
        <a href="">{{ $answer->title }}</a>  <!-- Add route to question page -->
        <h4>Answer:</h4>
        <p>{{ $answer->text_body }}</p>
        <p> {{ $answer-> date }} </p>
        @endforeach 
    @endif
</article>
@endsection