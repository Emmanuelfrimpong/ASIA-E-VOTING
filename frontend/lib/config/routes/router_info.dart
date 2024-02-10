class RouterInfo {
   String path;
   String ?name;
 
 
 
  RouterInfo({
    required this.path,
     this.name,
  });
   




   //! here i am going to define all my routes 
   static RouterInfo rootRoute= RouterInfo(path: '/login',name: 'login');
    static RouterInfo adminHomeRoute= RouterInfo(path: '/admin-home',name: 'admin-home');
    static RouterInfo userHomeRoute= RouterInfo(path: '/user-home',name: 'user-home');
    //forget password
    static RouterInfo forgetPasswordRoute= RouterInfo(path: '/forget-password',name: 'forget-password');
    //vote route
    static RouterInfo voteRoute= RouterInfo(path: '/vote',name: 'vote');
    //result route
    static RouterInfo resultRoute= RouterInfo(path: '/result',name: 'result');
    //admin crete election
    static RouterInfo adminCreateElectionRoute= RouterInfo(path: '/create-election',name: 'create-election');
    //admin list election
    static RouterInfo adminListElectionRoute= RouterInfo(path: '/elections',name: 'elections');
    //candidate route
    static RouterInfo candidateRoute= RouterInfo(path: '/candidate',name: 'candidate');
    //admin create candidate
    static RouterInfo adminCreateCandidateRoute= RouterInfo(path: '/create-candidate',name: 'create-candidate');
}
