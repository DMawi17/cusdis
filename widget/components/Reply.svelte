<script>
  import { getContext } from 'svelte'
  import { t } from '../i18n'
  export let parentId

  // form data
  let content = ''
  let nickname = ''
  let email = ''

  let loading = false

  export let onSuccess

  const api = getContext('api')
  const setMessage = getContext('setMessage')
  const { appId, pageId, pageUrl, pageTitle } = getContext('attrs')
  const refresh = getContext('refresh')

  async function addComment() {
    if (!content) {
      setMessage(t('content_is_required'))
      return
    }

    if (!nickname) {
      setMessage(t('nickname_is_required'))
      return
    }

    try {
      loading = true
      const res = await api.post('/api/open/comments', {
        appId,
        pageId,
        content,
        nickname,
        email,
        parentId,
        pageUrl,
        pageTitle,
      })
      await refresh()
      teardown()
      setMessage(t('comment_has_been_sent'))
    } finally {
      loading = false
    }
  }

  function teardown() {
    content = ''
    nickname = ''
    email = ''
    onSuccess && onSuccess()
  }

</script>

<div class="grid grid-cols-1 gap-3">
  <div class="grid grid-cols-2 gap-3">
    <div>
      <label for="nickname">{t('nickname')}</label>
      <input
        name="nickname"
        type="text"
        title={t('nickname')}
        placeholder={t('nickname_placeholder')}
        bind:value={nickname}
      />
    </div>
    <div>
      <label for="email">{t('email')}</label>
      <input
        name="email"
        type="email"
        title={t('email')}
        placeholder={t('email_placeholder')}
        bind:value={email}
      />
    </div>
  </div>

  <div>
    <label for="reply_content">{t('comment_label')}</label>
    <textarea
      name="reply_content"
      title={t('comment_label')}
      placeholder={t('comment_placeholder')}
      bind:value={content}
    />
  </div>

  <div>
    <button
      type="submit"
      class:cusdis-disabled={loading}
      disabled={loading}
      on:click={addComment}>{loading ? t('sending') : t('post_comment')}</button
    >
  </div>
</div>

<style>
  .cusdis-disabled {
    opacity: 0.6;
    cursor: not-allowed;
  }

  button:disabled {
    opacity: 0.6;
    cursor: not-allowed;
  }
</style>