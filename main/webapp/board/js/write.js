function sendit() {
  const form = document.writeform;
  const title = form.title;
  const content = form.content;

  if (title.value == "") {
    alert("제목을 입력해주세요");
    title.focus();
    return false;
  }
  if (content.value == "") {
    alert("내용을 작성해주세요");
    content.focus();
    return false;
  }

  return true;
}
