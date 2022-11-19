<h3>Tag management<h3>
    
    <table>
        <thead>
          <tr>
            <th>Tag</th>
            <th>Delete</th>
          </tr>
         </thead>
         <tbody>
           @foreach($tags as $tag)
           <tr>
             <td>{{$tag->name}}</td>
             <td>
                <form action="{{route('deleteTag')}}" method="POST">
                    @csrf
                    @method('DELETE')
                    <input type="hidden" name="id_tag" value="{{ $tag->id_tag }}"/>
                    <button type="submit">Delete</button>
                </form>
            </td>           
           </tr>
           @endforeach
        </tbody>
      </table>    
    <h4>Create tag:</h4>
    <form action="{{ route('createTag')}}" method="POST"> <!-- ROUTE -->
        {{ csrf_field() }}     
        <input type="text" name="tag" class="form-control" value="{{ old('tag') }}" required/>
        <label class="form-label" for="tag">New Tag</label>
        </div>
        @if ($errors->has('tag'))
        <span class="error">
            {{ $errors->first('tag') }}
        </span>
        @endif
        <button type="submit">Create Tag</button>
    </form>