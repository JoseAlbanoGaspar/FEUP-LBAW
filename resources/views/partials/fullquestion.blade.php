<div id="mainbar" class="p-5" aria-label="question and answers">

	<div id="question">

		<h1 id='question-title'>
			{{$post->question->title}}
		</h1>
		<small id='modified'>This question has been modified(FALTA AQUI) by <a>Joao7890</a> 2 hours ago</small>

		<div class="post-layout d-flex flex-row">
			<div class="flex--item">
				@include('partials.votebutton', ['post' => $post->question])
			</div>


			<div class="flex--item w-100">

				<p id='post-text-body' class="p-3">{{$post->text_body}}</p>

				<div class="d-flex flex-row fw-wrap justify-content-between m-2">
					<ul class="d-inline p-2">
						@foreach ($post->question->tags as $tag)
							<li class="d-inline mr4"><a href="" class="post-tag" aria-label="show questions tagged '{{$tag->name}}'"></a>{{$tag->name}}</li>
						@endforeach
					</ul>
					<small class="d-inline p-2">
						<a>{{$post->user->username}}</a> asked 1(FALTA)day ago
					</small>
				</div>

				<div class="d-flex align-items-center">
					<a role="button" class="btn btn-secondary btn-sm mx-2 text-center" href="{{ route('updatePostForm',['id_post' => $post->id_post]) }}">Edit</a>

				   	<!-- FALTA UM POP UP PARA CONFIRMAR -->
					<form method='POST' action='{{route('deletePost')}}'>
						{{ csrf_field() }}
						@method('DELETE')
						<input type="hidden" value="{{ $post->id_post }}" name="id_post"/>
						<button type="submit" class="btn btn-secondary btn-sm mx-2 text-center">Delete</button>
					</form>
				</div>

				@include('partials.comments', ['comments' => $post->question->comments])
			</div>
		</div>
	</div>



	<div id="answers">
		<div id="answers-header">
			<h2 class="mb0" data-answercount="2">
				<span itemprop="answerCount">{{count($answers)}}</span> Answers
			</h2>
		</div>
		<script>
			let text = 0;
			let edit_field = 0;
		</script>
		@foreach ($answers as $answer)
		<div id="answerid-{{$answer->id_answer}}" class="post-layout d-flex flex-row">
			<div class="flex--item">
				@include('partials.votebutton', ['post' => $answer])
			</div>


			<div id='answer-content-{{$answer->id_answer}}' class="flex--item m-2 w-100">

				<p id='answer-text-body-{{$answer->id_answer}}' class="p-3">{{$answer->post->text_body}}</p>

				<div class="d-flex flex-row fw-wrap p-2">
					<small>
						<a>{{$answer->post->user->username}}</a> answered 1(FALTA)day ago
					</small>

					<button id="editButton-{{$answer->id_answer}}" class="btn btn-secondary btn-sm mx-2 text-center" onclick="editAnswer({{$answer->id_answer}}, {{$answer->post->text_body}})">Edit</button>

					<!-- FALTA UM POP UP PARA CONFIRMAR -->
					<form method='POST' action='{{route('deletePost')}}'>
						{{ csrf_field() }}
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
			{{ csrf_field() }}
			<h2 class="space" id="your-answer-header">
				Your Answer
			</h2>
			<input type="hidden" value="{{ Auth::user()->id_user }}" name="id_author" />
			<textarea class="form-control" name="text_body" aria-label="Add answer" placeholder="Add answer" rows="8"></textarea>
			<div class="form-submit clear-both d-flex flex-row">
				<button id="submit-button" class="btn btn-secondary btn-sm mx-2 text-center" type="submit">
					Post Your Answer </button>
				<button class="btn btn-secondary btn-sm mx-2 text-center">
					Discard
				</button>
			</div>
		</form>
	</div>
</div>
