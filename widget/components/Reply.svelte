<div class="grid grid-cols-1 gap-3">
  <div class="grid grid-cols-2 gap-3">
    <div>
      <label class="mb-1.5 block text-sm dark:text-gray-200" for="nickname">{t('nickname')}</label>
      <input
        name="nickname"
        class="w-full p-2.5 border border-gray-300 bg-transparent dark:text-gray-100 dark:border-gray-600 dark:outline-none rounded-md"
        type="text"
        title={t('nickname')}
        bind:value={nickname}
      />
    </div>
    <div>
      <label class="mb-1.5 block text-sm dark:text-gray-200" for="email">{t('email')}</label>
      <input
        name="email"
        class="w-full p-2.5 border border-gray-300 bg-transparent dark:text-gray-100 dark:border-gray-600 dark:outline-none rounded-md"
        type="email"
        title={t('email')}
        bind:value={email}
      />
    </div>
  </div>

  <div>
    <label class="mb-1.5 block text-sm dark:text-gray-200" for="reply_content">{t('reply_placeholder')}</label>
    <textarea
      name="reply_content"
      class="w-full p-2.5 border border-gray-300 h-28 bg-transparent dark:text-gray-100 dark:border-gray-600 dark:outline-none rounded-md resize-none"
      title={t('reply_placeholder')}
      bind:value={content}
    />
  </div>

  <div>
    <button
      class="text-sm bg-blue-600 hover:bg-blue-700 text-white p-2.5 px-6 font-semibold rounded-md dark:bg-blue-700 dark:hover:bg-blue-800 transition-colors"
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