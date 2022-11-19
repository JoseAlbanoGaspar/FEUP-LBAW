<h3>Tag management<h3>
    @foreach($tags as $tag)
        <ul>
            <li>
                <div>
                    <p>$tag->name</p>
                    <form action="" method="POST"> <!-- ROUTE -->
                        <button type="submit">Delete</button>
                    </form>
                </div>
            </li>
        </ul>
    @endforeach
    <h4>Create tag:</h4>
    <form action="" method="POST"> <!-- ROUTE -->
        {{ csrf_field() }}     
        <input type="text" name="tag" class="form-control" value="{{ old('tag') }}" required/>
        <label class="form-label" for="tag">Username</label>
        </div>
        @if ($errors->has('tag'))
        <span class="error">
            {{ $errors->first('tag') }}
        </span>
        @endif
    </form>