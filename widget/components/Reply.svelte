<script>
  import { getContext, onDestroy } from 'svelte'
  import { t } from '../i18n'
  export let parentId
  export let message = ''
  export let messageType = 'error'

  // form data
  let content = ''
  let nickname = ''
  let email = ''

  let loading = false
  let messageTimeout = null

  export let onSuccess

  const api = getContext('api')
  const setMessage = getContext('setMessage')
  const { appId, pageId, pageUrl, pageTitle } = getContext('attrs')
  const refresh = getContext('refresh')

  // Clear message after 5 seconds
  function showTemporaryMessage(msg, type) {
    setMessage(msg, type)

    // Clear any existing timeout
    if (messageTimeout) {
      clearTimeout(messageTimeout)
    }

    // Set new timeout to clear message after 5 seconds
    messageTimeout = setTimeout(() => {
      setMessage('', 'error')
    }, 5000)
  }

  async function addComment() {
    if (!content) {
      showTemporaryMessage(t('content_is_required') + '!', 'error')
      return
    }

    if (!nickname) {
      showTemporaryMessage(t('nickname_is_required') + '!', 'error')
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
      showTemporaryMessage(t('comment_has_been_sent'), 'success')
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

  // Cleanup timeout on component destroy
  onDestroy(() => {
    if (messageTimeout) {
      clearTimeout(messageTimeout)
    }
  })

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

  <div style="display: flex; align-items: center; gap: 1rem; min-height: 44px;">
    <button
      type="submit"
      class:cusdis-disabled={loading}
      disabled={loading}
      on:click={addComment}>{loading ? t('sending') : t('post_comment')}</button
    >
    {#if message}
      <span class="text-sm" style="color: {messageType === 'success' ? '#16a34a' : '#dc2626'}; flex: 1;">
        {message}
      </span>
    {/if}
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