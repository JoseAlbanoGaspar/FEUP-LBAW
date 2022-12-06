
<table  class="table table-striped">
     <tbody>
        @foreach ($reports as $report)
        <thead>
            <tr>
              <th>ID</th>
              <th>No. Reports</th>
              <th>Reasons</th>
              <th>Dismiss</th>
            </tr>
           </thead>  
        <tr>
         <td>{{$report['id_post']}}</td>
         <td>{{$report['counter']}}</td>
         <td>
            <ul>
                @foreach($report['reasons'] as $reason)
                    <li>{{$reason}}</li>
                @endforeach
            </ul>
         </td>
         <td>
            <form action="{{route('dismissReport')}}" method="POST">  <!-- DO ROUTE -->
                @csrf
                @method('DELETE')
                <input type="hidden" name="id_post" value="{{ $report['id_post']}}"/>
                <button type="submit" class="btn btn-danger btn-sm h-auto">Dismiss</button>
            </form>
        </tr>
        <tr>
            <td colspan="4">@include('partials.postListing',['postListing' => $report['post']])</td>
        </tr>
        @endforeach
    </tbody>
  </table>



    