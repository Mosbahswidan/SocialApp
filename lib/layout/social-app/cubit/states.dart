abstract class SocialStates{
}
class SocialInitialState extends SocialStates{}

class SocialGetUserSuccsess extends SocialStates{}
class SocialGetUserLoading extends SocialStates{}
class SocialGetUserError extends SocialStates{
  final String error;

  SocialGetUserError(this.error);
}


class SocialGetAllUserSuccsess extends SocialStates{}
class SocialGetAllUserLoading extends SocialStates{}
class SocialGetAllUserError extends SocialStates{
  final String error;

  SocialGetAllUserError(this.error);
}


//get post state
class SocialGetPostSuccsess extends SocialStates{}
class SocialGetPostLoading extends SocialStates{}
class SocialGetPostError extends SocialStates{
  final String error;

  SocialGetPostError(this.error);
}

class SocialLikePostSuccsess extends SocialStates{}
class SocialLikePostError extends SocialStates{
  final String error;

  SocialLikePostError(this.error);
}

class SocialChangeBottomNav extends SocialStates{}
class SocialAddPostState extends SocialStates{}

class SocialProfileImagePickedSuccess extends SocialStates{}
class SocialProfileImagePickedError extends SocialStates{}



class SocialCoverImagePickedSuccess extends SocialStates{}
class SocialCoverImagePickedError extends SocialStates{}


class SocialpostImagePickedSuccess extends SocialStates{}
class SocialpostImagePickedError extends SocialStates{}

class SocialchatImagePickedSuccess extends SocialStates{}
class SocialchatImagePickedError extends SocialStates{}

class SocialDeleteChatImage extends SocialStates{}
class SocialUpdateUserError extends SocialStates{}

// create post states
class SocialCreatePostError extends SocialStates{}
class SocialCreatePostSucces extends SocialStates{}
class SocialCreatePostLoading extends SocialStates{}


class SocialWrriteCommentSuccess extends SocialStates{}
class SocialWrriteCommentError extends SocialStates{
  final String error;

  SocialWrriteCommentError(this.error);
}


class SocialGetCommentSuccsess extends SocialStates{}
class SocialGetCommentLoading extends SocialStates{}
class SocialGetCommentError extends SocialStates {
  final String error;

  SocialGetCommentError(this.error);
}


class SocialSendMessageSuccsess extends SocialStates{}
class SocialSendMessageError extends SocialStates{}
class SocialGetMessageSuccsess extends SocialStates{}
class SocialGetMessageError extends SocialStates{}


class SocialGetCommentsSuccessState extends SocialStates{}


class SocialSendChatImageLoading extends SocialStates{}
class SocialSendChatImageSuccsess extends SocialStates{}
class SocialSendChatImageError extends SocialStates{}

 class SocialGetUserPostSuccess extends SocialStates{}
class SocialGetUserPostError extends SocialStates{}






