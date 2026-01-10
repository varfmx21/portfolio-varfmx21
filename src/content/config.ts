import { defineCollection, z } from 'astro:content';

const blog = defineCollection({
  type: 'content',
  schema: z.object({
    title: z.string(),
    description: z.string(),
    date: z.date(),
    author: z.string().optional(),
    image: z.string().optional(), // Ruta de la imagen (ej: 'mi-post.webp')
    tags: z.array(z.string()).optional(),
  }),
});

export const collections = {
  blog,
};
