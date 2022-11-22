<h5 class="m-2 my-4">Delete Tags</h5>

<section id="delete_tags">
  <table class="table table-striped">
    <thead>
      <tr>
        <th scope="col">Tag</th>
        <th scope="col">Questions</th>
        <th scope="col">Delete</th>
      </tr>
      </thead>
      <tbody>
        @foreach($tags as $tag)
        <tr>
          <th scope="row">{{$tag->name}}</td>
          <td>{{$tag->questions->count()}}</td>
          <td>
            <form action="{{route('deleteTag')}}" method="POST">
                @csrf
                @method('DELETE')
                <input type="hidden" name="id_tag" value="{{ $tag->id_tag }}"/>
                <button type="submit" class="btn btn-danger btn-sm h-auto">Delete</button>
            </form>
        </td>           
        </tr>
        @endforeach
    </tbody>
  </table>  
</section>    
      
<h5 class="m-2 my-4">Create Tag</h5>

<form action="{{ route('createTag')}}" method="POST"> <!-- ROUTE -->
    {{ csrf_field() }}     

    <div class="form-outline mb-2">
    <input type="text" name="tag" class="form-control" value="{{ old('tag') }}" required/>
    <label class="form-label" for="tag">New Tag</label>
    </div>

    @if ($errors->has('tag'))
    <span class="error">
        {{ $errors->first('tag') }}
    </span>
    @endif
    <div class="d-flex justify-content-end">
      <button type="submit" class="btn btn-primary btn-block mx-4 mb-3">Create Tag</button>
    </div>
</form>