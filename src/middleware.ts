import { defineMiddleware } from 'astro:middleware';

export const onRequest = defineMiddleware((context, next) => {
  const { url, cookies, redirect } = context;
  const isLoginPage = url.pathname.startsWith('/login');
  
  // We check for access token.
  // We use "lax" check here, a better approach requires Supabase SSR client validation, 
  // but for PRD scope this simple cookie check provides basic route protection.
  const accessToken = cookies.get('sb-access-token');

  if (!isLoginPage && !accessToken) {
    return redirect('/login');
  }

  if (isLoginPage && accessToken) {
    return redirect('/dashboard');
  }

  return next();
});
