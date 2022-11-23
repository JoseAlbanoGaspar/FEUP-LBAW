@php
	include_once(app_path() . '/Includes/Utils.php');
@endphp

<div id="question_header" class="d-flex flex-column mx-3 mx-md-5 mt-5">
	<div class="d-flex flex-row align-items-center justify-content-between">
		<h1 id="question_title">{{$post->question->title}}</h1>
		<a role="button" class="btn btn-secondary btn mx-2 text-center" href="{{ route('FormToAskQuestion') }}">Ask Question</a>
	</div>

	{{--A bar that includes the post date, the edit date and the number of answers--}}
	<div class="d-flex flex-row align-items-center justify-content-start">
		<time class="p-2">Posted {{timeElapsedString($post->date)}}</time>
		{{--<time class="p-2">Edited TODO</time>--}}
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

				<div class="d-flex flex-row justify-content-end py-1 p-2">
					<small>
						<div class = "user-card col d-inline d-flex justify-content-end">
							@include('partials.profile-card', ['user' => $post->user])
			
							<time class="user-card-time flex-shrink">
								&nbsp;asked {{timeElapsedString($post->date)}}
							</time>
						</div>
					</small>
				</div>

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
			<h3 class="mb-3">
				<span itemprop="answerCount">{{count($answers)}}</span> Answers
			</h3>
		</div>

		@foreach ($answers as $answer)
		<div id="answerid-{{$answer->id_answer}}" class="post-layout d-flex flex-row mb-3">
			<div class="d-flex flex-column align-items-center">

				@if($answer->is_solution)
					<h5> <a href='#' data-toogle="tooltip" data-bs-placement="right" title="The question onwer accepted this as the best answer" class="text-center"><i class="fa fa-check" aria-hidden="true"></i></a> </h5>
				@endif

				@include('partials.votebutton', ['post' => $answer])
			</div>


			<div class="flex--item px-3 w-100">

				<p id='post-text-body'>{{$answer->post->text_body}}</p>

				<div class="d-flex flex-row justify-content-end py-1 p-2">
					<small>
						<div class = "user-card col d-inline d-flex justify-content-end">
							@include('partials.profile-card', ['user' => $answer->post->user])
			
							<time class="user-card-time flex-shrink">
								&nbsp;answered {{timeElapsedString($answer->post->date)}}
							</time>
						</div>
					</small>
				</div>


				<div class="d-flex flex-row">
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
			
			<h3 class="mb-3">
				Your Answer
			</h3>

			<textarea class="form-control" aria-label="Add answer" placeholder="Add answer" rows="8"></textarea>
			<div class="form-submit clear-both d-flex flex-row justify-content-end mt-3">
				<button id="submit-button" class="btn btn-outline-secondary" type="submit">
					Post Your Answer </button>
				<button class="btn btn-outline-secondary">
					Discard
				</button>
			</div>
		</form>
	</div>
</div>
