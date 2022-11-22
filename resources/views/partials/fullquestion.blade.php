@php
	include_once(app_path() . '/Includes/Utils.php');
@endphp

<div id="question_header" class="d-flex flex-column mx-3 mx-md-5 mt-5">
	<div class="d-flex flex-row align-items-center justify-content-between">
		<h1 id="question_title">{{$post->question->title}}</h1>
		<a role="button" class="btn btn-secondary btn-sm mx-2 text-center" href="{{ route('FormToAskQuestion') }}">Ask Question</a>
	</div>

	{{--A bar that includes the post date, the edit date and the number of answers--}}
	<div class="d-flex flex-row align-items-center justify-content-start">
		<time class="p-2">Posted {{timeElapsedString($post->date)}}</time>
		<time class="p-2">Edited TODO</time>
		<span class="p-2">{{sizeof($answers)}} answers</span>
	</div>
</div>

{{--The question body--}}

<div id="mainbar" class="p-3" aria-label="question and answers">

	<div id="question">
		<div class="post-layout d-flex flex-row">
			<div class="flex--item">
				@include('partials.votebutton', ['post' => $post->question])
			</div>


			<div class="flex--item w-100 px-3">

				<p id='post-text-body'>{{$post->text_body}}</p>

				<div class="d-flex flex-row fw-wrap justify-content-between m-2">
					<div class="col d-flex justify-content-start">
						<ul class="post-summary-meta-tags list-ls-none d-inline">
							@foreach($post->question->tags as $tag)
								<li class="d-inline mr4"><a role="button" class="btn btn-outline-primary btn-sm" href="{{route('tags', ['name' => $tag->name])}}" class="post-tag flex--item">{{$tag->name}}</a></li>
							@endforeach
						</ul>
					</div>
				</div>

				<div class="d-flex align-items-center">
					<a role="button" class="btn btn-secondary btn-sm mx-2 text-center" href="{{ route('updatePostForm',['id_post' => $post->id_post]) }}">Edit</a>

				   	<!-- FALTA UM POP UP PARA CONFIRMAR -->
					<form method='POST' action='{{route('deletePost')}}'>
						{{-- csfr_field() --}}
						@method('DELETE')
						<input type="hidden" value="{{ $post->id_post }}" name="id_post"/>
						<button type="submit" class="btn btn-secondary btn-sm mx-2 text-center">Delete</button>
					</form>
				</div>

				@include('partials.comments', ['comments' => $post->question->comments])
			</div>
		</div>
	</div>



	<div id="answers" class="mt-5">
		<div id="answers-header">
			<h3 class="mb0" data-answercount="2">
				<span itemprop="answerCount">{{count($answers)}}</span> Answers
			</h3>
		</div>

		@foreach ($answers as $answer)
		<div id="answerid-{{$answer->id_answer}}" class="post-layout d-flex flex-row">
			<div class="flex--item">
				@include('partials.votebutton', ['post' => $answer])
			</div>


			<div class="flex--item m-2 w-100">

				<p id='post-text-body' class="p-3">{{$answer->post->text_body}}</p>

				<div class="d-flex flex-row fw-wrap p-2">
					<small>
						<a>{{$answer->post->user->username}}</a> answered 1(FALTA)day ago
					</small>

					<!-- NÃO SEI COMO EDITAR A RESPOSTA: NOVO FORM OU SO MUDAR NA PROPRIA PAGINA C JAVASCRIPT? -->
					<a role="button" class="btn btn-secondary btn-sm mx-2 text-center" href="{{ route('updatePostForm',['id_post' => $post->id_post]) }}">Edit</a>

					<!-- FALTA UM POP UP PARA CONFIRMAR -->
					<form method='POST' action='{{route('deletePost')}}'>
						{{-- csfr_field() --}}
						@method('DELETE')
						<input type="hidden" value="{{ $answer->id_answer }}" name="id_post"/>
						<button type="submit" class="btn btn-secondary btn-sm mx-2 text-center">Delete</button>
					</form>
				</div>


				@include('partials.comments', ['comments' => $answer->comments])
			</div>
		</div>
		@endforeach

		<form method="POST" action="{{ route('postAnswer',['id_question' => $post->id_post]) }}" enctype="multipart/form-data">
			<h2 class="space" id="your-answer-header">
				Your Answer
			</h2>
			<textarea class="form-control" aria-label="Add answe" placeholder="Add answer" rows="8"></textarea>
			<div class="form-submit clear-both d-flex flex-row">
				<button id="submit-button" class="btn btn-outline-secondary" type="submit">
					Post Your Answer </button>
				<button class="btn btn-outline-secondary">
					Discard
				</button>
			</div>
		</form>
	</div>
</div>
